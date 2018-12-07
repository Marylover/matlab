% ssb_audio.m
% 程序对含有噪声的语音信号进行滤波处理，然后进行SSB调制，经过含有噪声的信道后进行相干解调，相干解调存在载波频偏。
% 同学们可以尝试录制自己的声音，当然可以在有高频噪声情况下录制，然后尝试安装下面的处理流程对其进行处理，要注意改变滤波器、载波频偏等参数，播放来比较输出效果。
% Liu longwei in 2016.9.23, sunllw@163.com

clc;
clear all;
close all; 

[wav,fs]=audioread('GDGvoice8000.wav');
t_end=1/fs *length(wav);  % 计算声音的时间长度
Fs=50000;                 % 仿真系统采样率
t=1/Fs:1/Fs:t_end;        % 仿真系统采样时间点
% 设计300Hz～3400Hz的带通预滤波器H(z) 
[fenzi,fenmu]=butter(3,[300 3400]/(fs/2));
% 对音频信号进行预滤波 
wav=filter(fenzi,fenmu,wav);
% 利用插值函数将音频信号的采样率提升为Fs=50KHz 
wav=interp1([1/fs:1/fs:t_end],wav,t,'spline');
wav_hilbert=imag(hilbert(wav)); % 音频信号的希尔伯特变换
fc=10000;                       % 载波频率Hz
SSB_OUT=wav.*cos(2*pi*fc*t)-wav_hilbert.*sin(2*pi*fc*t); % 单边带调制 
figure(1);                      % 观察调制前后频谱 
subplot(2,2,1); plot(wav(53550:53750));     axis([0 200 -0.3 0.3]);
subplot(2,2,2); psd(wav, 10000, Fs);        axis([0 25000 -20 10]);
subplot(2,2,3); plot(SSB_OUT(53550:53750)); axis([0 200 -0.3 0.3]);
subplot(2,2,4); psd(SSB_OUT, 10000, Fs);    axis([0 25000 -20 10]);

SNRdB=20;                             %dB设计的信道信噪比
channel_out=channel_ssb_audio(SSB_OUT,SNRdB);

fc_local=10000-200;                         % 本地载波频率9.8KHz,注意存在载波频率便宜，同学们可以改变偏移量，看对解调语音质量的影响。
local_carrier=cos(2*pi*fc_local.*t);        % 本地载波
xianggan_out=channel_out.*local_carrier;     % 相干解调
[fenzi,fenmu]=butter(3,[300 3400]/(Fs/2));  % 设计300Hz～3400Hz的带通滤波器
demod_out=filter(fenzi,fenmu,xianggan_out); % 对相干输出信号进行滤波
sound(demod_out/max(demod_out), Fs);        % 播放解调音频
wavwrite(demod_out,Fs,'SSBDemod_OUT.wav');  % 保存输出信号


