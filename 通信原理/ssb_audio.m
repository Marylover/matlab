% ssb_audio.m
% ����Ժ��������������źŽ����˲�����Ȼ�����SSB���ƣ����������������ŵ��������ɽ������ɽ�������ز�Ƶƫ��
% ͬѧ�ǿ��Գ���¼���Լ�����������Ȼ�������и�Ƶ���������¼�ƣ�Ȼ���԰�װ����Ĵ������̶�����д���Ҫע��ı��˲������ز�Ƶƫ�Ȳ������������Ƚ����Ч����
% Liu longwei in 2016.9.23, sunllw@163.com

clc;
clear all;
close all; 

[wav,fs]=audioread('GDGvoice8000.wav');
t_end=1/fs *length(wav);  % ����������ʱ�䳤��
Fs=50000;                 % ����ϵͳ������
t=1/Fs:1/Fs:t_end;        % ����ϵͳ����ʱ���
% ���300Hz��3400Hz�Ĵ�ͨԤ�˲���H(z) 
[fenzi,fenmu]=butter(3,[300 3400]/(fs/2));
% ����Ƶ�źŽ���Ԥ�˲� 
wav=filter(fenzi,fenmu,wav);
% ���ò�ֵ��������Ƶ�źŵĲ���������ΪFs=50KHz 
wav=interp1([1/fs:1/fs:t_end],wav,t,'spline');
wav_hilbert=imag(hilbert(wav)); % ��Ƶ�źŵ�ϣ�����ر任
fc=10000;                       % �ز�Ƶ��Hz
SSB_OUT=wav.*cos(2*pi*fc*t)-wav_hilbert.*sin(2*pi*fc*t); % ���ߴ����� 
figure(1);                      % �۲����ǰ��Ƶ�� 
subplot(2,2,1); plot(wav(53550:53750));     axis([0 200 -0.3 0.3]);
subplot(2,2,2); psd(wav, 10000, Fs);        axis([0 25000 -20 10]);
subplot(2,2,3); plot(SSB_OUT(53550:53750)); axis([0 200 -0.3 0.3]);
subplot(2,2,4); psd(SSB_OUT, 10000, Fs);    axis([0 25000 -20 10]);

SNRdB=20;                             %dB��Ƶ��ŵ������
channel_out=channel_ssb_audio(SSB_OUT,SNRdB);

fc_local=10000-200;                         % �����ز�Ƶ��9.8KHz,ע������ز�Ƶ�ʱ��ˣ�ͬѧ�ǿ��Ըı�ƫ���������Խ������������Ӱ�졣
local_carrier=cos(2*pi*fc_local.*t);        % �����ز�
xianggan_out=channel_out.*local_carrier;     % ��ɽ��
[fenzi,fenmu]=butter(3,[300 3400]/(Fs/2));  % ���300Hz��3400Hz�Ĵ�ͨ�˲���
demod_out=filter(fenzi,fenmu,xianggan_out); % ���������źŽ����˲�
sound(demod_out/max(demod_out), Fs);        % ���Ž����Ƶ
wavwrite(demod_out,Fs,'SSBDemod_OUT.wav');  % ��������ź�


