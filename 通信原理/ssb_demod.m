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
s_SSB2=m_t.*carriercos+m_t90shift.*carriersin; % 下边带SSB


out=s_SSB1.*carriercos;      % 相干解调
[a,b]=butter(6, 500/(Fs/2)); % 低通滤波器设计4阶,截止频率为500Hz
demodsig=filter(a,b,out);    % 解调输出

out2=s_SSB2.*carriercos;      % 相干解调
[a,b]=butter(4, 500/(Fs/2)); % 低通滤波器设计4阶,截止频率为500Hz
demodsig2=filter(a,b,out2);    % 解调输出


% 下面作出各波形以及频谱
figure(1);
subplot(3,2,1); plot(t(1:100),s_SSB1(1:100)); % SSB波形
                title('上边带SSB时域波形');
subplot(3,2,2); fftAndPlot(s_SSB1,Fs); % SSB频谱
                title('上边带SSB频谱');
subplot(3,2,3); plot(t(1:200),out(1:200));       % 相干解调波形
                title('上边带SSB相干解调时域波形');
subplot(3,2,4); fftAndPlot(out,Fs);    % 相干解调频谱
                title('上边带SSB相干解调频谱')
                
subplot(3,2,5); plot(t(1:200),demodsig(1:200));   % 低通输出信号
                title('上边带SSB低通输出时域波形');
subplot(3,2,6); fftAndPlot(demodsig,Fs);% 低通输出信号的频谱
                title('上边带SSB低通输出频谱');
                
figure(2);      
plot(t(1:100),m_t(1:100));    % SSB波形
title('基带信号时域波形');
% xlim([0 1]);
% ylim([-100,100]);

figure(3);      
fftAndPlot(m_t,Fs)    % SSB波形
title('基带信号频谱');
xlim([-1000,1000]);
 
figure(4);
subplot(3,2,1); plot(t(1:100),s_SSB2(1:100)); % SSB波形
                title('下边带SSB时域波形');
subplot(3,2,2); fftAndPlot(s_SSB2,Fs); % SSB频谱
                title('下边带SSB频谱');
subplot(3,2,3); plot(t(1:1000),out2(1:1000));       % 相干解调波形
                title('下边带SSB相干解调时域波形');
subplot(3,2,4); fftAndPlot(out2,Fs);    % 相干解调频谱
                title('下边带SSB相干解调频谱')
                
subplot(3,2,5); plot(t(1:1000),demodsig2(1:1000));   % 低通输出信号
                title('下边带SSB低通输出时域波形');
subplot(3,2,6); fftAndPlot(demodsig2,Fs);% 低通输出信号的频谱
                title('下边带SSB低通输出频谱');
                
                
 figure(5);
 subplot(2,2,1); plot(t(1:100),carriercos(1:100));
 title('载波时域波形');
 subplot(2,2,2); fftAndPlot(carriercos,Fs)
 title('载波频谱');
 
 subplot(2,2,3); plot(t(1:100),carriersin(1:100));
 title('正交载波时域波形');
 subplot(2,2,4);fftAndPlot(carriersin,Fs)
 title('正交载波频谱');
 