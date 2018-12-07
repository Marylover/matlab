% quantization_sim.m
% Liu longwei in 2016.9.28, sunllw@163.com
%Ҫ��ͬѧ�ǱȽϾ��������ͷǾ���������������ȵ����𣬲�������ֵ��ʵ�ʲ���ֵ���жԱȡ�
clc;
clear all;
close all; 

freq=1;     % �������Ҳ�Ƶ��
AdB=-60:1:0;% �����ƽ���ֱ���
A=10.^(AdB./20);
for mu=[0.001, 255];% ���������ͷǾ����������
  for k=1:length(A)
     sourceAmp=A(k);         % �źŵ�ƽ��ֵ
     sim('quantization_sim.mdl'); % ��������ģ��
     SNR(k)=10*log10(SandN(2)./SandN(1));% �������������
 end
 plot(AdB,SNR,'o');hold on;drawnow; % �������������
end
xlabel('�����źŵ�ƽ dB');ylabel('��������� dB');
axis([-60 0 0 50]);
% ���ۼ�������
SNR_dB=6*8+1.76+20*log10(A);
mu=255;
Q_dB=20*log10(mu/(log(1+mu)))-20*log10(1+mu*A);
SNR_dB_mulaw=SNR_dB+Q_dB;
plot(AdB,SNR_dB,'-',AdB,SNR_dB_mulaw,'--');