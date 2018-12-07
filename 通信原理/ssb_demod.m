% ssb_demod.m
% Liu longwei in 2016.9.27, sunllw@163.com
clc
clear all
close all

Fs=10000;      % ����Ĳ�����
t=1/Fs:1/Fs:1; % ����ʱ���
m_t(Fs*1)=0;   % �����źű�����ʼ��
for F=150:400  % �����źŷ�����Ƶ��150Hz��400Hz
    m_t=m_t+0.003*sin(2*pi*F*t)*(400-F); % ���������Եݼ�
end
m_t90shift=imag(hilbert(m_t)); % �����źŵ�ϣ�����ر任
carriercos=cos(2*pi*1000*t);   % 1000Hz�ز� cos
carriersin=sin(2*pi*1000*t);   % 1000Hz�����ز� sin
s_SSB1=m_t.*carriercos-m_t90shift.*carriersin; % �ϱߴ�SSB

out=s_SSB1.*carriercos;      % ��ɽ��
[a,b]=butter(4, 500/(Fs/2)); % ��ͨ�˲������4��,��ֹƵ��Ϊ500Hz
demodsig=filter(a,b,out);    % ������
% ���������������Լ�Ƶ��
figure(1);
subplot(3,2,1); plot(t(1:1000),s_SSB1(1:1000));    % SSB����
subplot(3,2,2); plot([0:9999],abs(fft(s_SSB1))); % SSBƵ��
                axis([0 5000 -500 6000]);
subplot(3,2,3); plot(t(1:1000),out(1:1000));       % ��ɽ������
subplot(3,2,4); plot([0:9999],abs(fft(out)));    % ��ɽ��Ƶ��
                axis([0 3000 -500 6000]);
subplot(3,2,5); plot(t(1:1000),demodsig(1:1000));   % ��ͨ����ź�
subplot(3,2,6); plot([0:9999],abs(fft(demodsig)));% ��ͨ����źŵ�Ƶ��
                axis([0 3000 -500 6000]);
figure(2);      
plot(m_t);    % SSB����
figure(3);      
plot(s_SSB1);    % SSB����
 