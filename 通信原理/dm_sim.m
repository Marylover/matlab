% dm_sim.m
% �ڶ�������Ļ����ϣ��۲�������Σ��ر��ǽ�������ԭ�źŲ��ζԱȣ���ͼ��ָ������ʧ��͹���ʧ��Ĳ��ֲ��Ρ�
% Liu longwei in 2016.9.28, sunllw@163.com
clc
clear all
close all

Ts=1e-3;      % �������
t=0:Ts:20*Ts; % ����ʱ������
x=sin(2*pi*50*t)+0.5*sin(2*pi*150*t);% �ź�
delta=0.4;    % �����׾�
D(1+length(t))=0;                % Ԥ������ʼ״̬
for k=1:length(t)
    e(k)=x(k)-D(k);              % ����ź�
    e_q(k)=delta*(2*(e(k)>=0)-1);% ���������
    D(k+1)=e_q(k)+D(k);          % �ӳ���״̬����
    codeout(k)=(e_q(k)>0);       % �������
end
subplot(3,1,1);plot(t,x,'-o');axis([0 20*Ts,-2 2]); hold on;
subplot(3,1,2);stairs(t,codeout);axis([0 20*Ts,-2 2]);
                                 % �����
Dr(1+length(t))=0;               % �����Ԥ������ʼ״̬
for k=1:length(t)
    eq(k)=delta*(2*codeout(k)-1);% ����
    xr(k)=eq(k)+Dr(k);
    Dr(k+1)=xr(k);               % �ӳ���״̬����
end
subplot(3,1,3);stairs(t,xr);hold on;% �������
subplot(3,1,3);plot(t,x);           % ԭ�ź�