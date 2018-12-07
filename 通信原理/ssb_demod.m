% ssb_demod.m
% Liu longwei in 2016.9.27, sunllw@163.com
clc
clear all
close all

Fs=10000;      % 仿真的采样率
t=1/Fs:1/Fs:1; % 仿真时间点
m_t(Fs*1)=0;   % 基带信号变量初始化
for F=150:400  % 基带信号发生：频率150Hz～400Hz
    m_t=m_t+0.003*sin(2*pi*F*t)*(400-F); % 幅度随线性递减
end
m_t90shift=imag(hilbert(m_t)); % 基带信号的希尔伯特变换
carriercos=cos(2*pi*1000*t);   % 1000Hz载波 cos
carriersin=sin(2*pi*1000*t);   % 1000Hz正交载波 sin
s_SSB1=m_t.*carriercos-m_t90shift.*carriersin; % 上边带SSB

out=s_SSB1.*carriercos;      % 相干解调
[a,b]=butter(4, 500/(Fs/2)); % 低通滤波器设计4阶,截止频率为500Hz
demodsig=filter(a,b,out);    % 解调输出
% 下面作出各波形以及频谱
figure(1);
subplot(3,2,1); plot(t(1:1000),s_SSB1(1:1000));    % SSB波形
subplot(3,2,2); plot([0:9999],abs(fft(s_SSB1))); % SSB频谱
                axis([0 5000 -500 6000]);
subplot(3,2,3); plot(t(1:1000),out(1:1000));       % 相干解调波形
subplot(3,2,4); plot([0:9999],abs(fft(out)));    % 相干解调频谱
                axis([0 3000 -500 6000]);
subplot(3,2,5); plot(t(1:1000),demodsig(1:1000));   % 低通输出信号
subplot(3,2,6); plot([0:9999],abs(fft(demodsig)));% 低通输出信号的频谱
                axis([0 3000 -500 6000]);
figure(2);      
plot(m_t);    % SSB波形
figure(3);      
plot(s_SSB1);    % SSB波形
 