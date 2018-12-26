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
s_SSB2=m_t.*carriercos+m_t90shift.*carriersin; % �±ߴ�SSB


out=s_SSB1.*carriercos;      % ��ɽ��
[a,b]=butter(6, 500/(Fs/2)); % ��ͨ�˲������4��,��ֹƵ��Ϊ500Hz
demodsig=filter(a,b,out);    % ������

out2=s_SSB2.*carriercos;      % ��ɽ��
[a,b]=butter(4, 500/(Fs/2)); % ��ͨ�˲������4��,��ֹƵ��Ϊ500Hz
demodsig2=filter(a,b,out2);    % ������


% ���������������Լ�Ƶ��
figure(1);
subplot(3,2,1); plot(t(1:100),s_SSB1(1:100)); % SSB����
                title('�ϱߴ�SSBʱ����');
subplot(3,2,2); fftAndPlot(s_SSB1,Fs); % SSBƵ��
                title('�ϱߴ�SSBƵ��');
subplot(3,2,3); plot(t(1:200),out(1:200));       % ��ɽ������
                title('�ϱߴ�SSB��ɽ��ʱ����');
subplot(3,2,4); fftAndPlot(out,Fs);    % ��ɽ��Ƶ��
                title('�ϱߴ�SSB��ɽ��Ƶ��')
                
subplot(3,2,5); plot(t(1:200),demodsig(1:200));   % ��ͨ����ź�
                title('�ϱߴ�SSB��ͨ���ʱ����');
subplot(3,2,6); fftAndPlot(demodsig,Fs);% ��ͨ����źŵ�Ƶ��
                title('�ϱߴ�SSB��ͨ���Ƶ��');
                
figure(2);      
plot(t(1:100),m_t(1:100));    % SSB����
title('�����ź�ʱ����');
% xlim([0 1]);
% ylim([-100,100]);

figure(3);      
fftAndPlot(m_t,Fs)    % SSB����
title('�����ź�Ƶ��');
xlim([-1000,1000]);
 
figure(4);
subplot(3,2,1); plot(t(1:100),s_SSB2(1:100)); % SSB����
                title('�±ߴ�SSBʱ����');
subplot(3,2,2); fftAndPlot(s_SSB2,Fs); % SSBƵ��
                title('�±ߴ�SSBƵ��');
subplot(3,2,3); plot(t(1:1000),out2(1:1000));       % ��ɽ������
                title('�±ߴ�SSB��ɽ��ʱ����');
subplot(3,2,4); fftAndPlot(out2,Fs);    % ��ɽ��Ƶ��
                title('�±ߴ�SSB��ɽ��Ƶ��')
                
subplot(3,2,5); plot(t(1:1000),demodsig2(1:1000));   % ��ͨ����ź�
                title('�±ߴ�SSB��ͨ���ʱ����');
subplot(3,2,6); fftAndPlot(demodsig2,Fs);% ��ͨ����źŵ�Ƶ��
                title('�±ߴ�SSB��ͨ���Ƶ��');
                
                
 figure(5);
 subplot(2,2,1); plot(t(1:100),carriercos(1:100));
 title('�ز�ʱ����');
 subplot(2,2,2); fftAndPlot(carriercos,Fs)
 title('�ز�Ƶ��');
 
 subplot(2,2,3); plot(t(1:100),carriersin(1:100));
 title('�����ز�ʱ����');
 subplot(2,2,4);fftAndPlot(carriersin,Fs)
 title('�����ز�Ƶ��');
 