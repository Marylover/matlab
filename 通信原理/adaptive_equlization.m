% adaptive_equlization.m
% Liu longwei in 2016.9.29, sunllw@163.com
clc
clear all
close all

Ts=1e-3;               % ��Ԫʱ϶Ts=1ms ,��Ӧ��������Ϊ1000bps
r=0.5;                 % ����ϵ��
t=(-10e-3):1e-4:10e-3; % ʱ���-10ms ��+10ms ��20 ��ʱ϶
[num,den] = rcosine(1e3,1e4,'fir/sqrt',r,10); % ƽ���������˲������
data=sign(rand(1,5000)-0.5);                  % ����5000 ���������,˫����.
datain=[data;zeros(9,length(data))];          % ��ÿ������ȡ��10����
datain=reshape(datain,1,10*length(data)); % ��1�������,����9��Ϊ0,��弤
figure
plot(datain);
wavout=filter(num,den,datain); % �����˲�
figure
plot(wavout);
n=10;fs=10000;fc=500;          % ��ͨ�ŵ�
[B,A] = butter(n,fc/(fs/2));   % ��ֹƵ��Ϊfc=500Hz��10�װ�����˼��ͨ�˲���
noise=0.00*randn(size(wavout));
wavout=wavout+noise;           % ��������
wavout1=filter(B,A,wavout);    % �����ŵ�1(500Hz��ͨ)
wavout2=0.2*[zeros(1,24),wavout(1:length(wavout)-24)]+...
        1*[zeros(1,34),wavout(1:length(wavout)-34)]+...
        0.4*[zeros(1,44),wavout(1:length(wavout)-44)];% �����ŵ�2(�ྶ�ŵ�)
wavout=[wavout1(1:20000),wavout2(20001:length(wavout))];
% �ŵ��ڵ�2��ʱ���л�
wavout=filter(num,den,wavout);     % ����ƥ���˲���
rec=wavout(225:10:length(wavout)); 
% �����ʱ��ÿ��10��ȡ��һ��,Լ�ӳ�201+24��ֵ
recpj=sign(rec);                   % �о�����о�����Ϊ0,���÷��ź�����������о�
% ����Ӧ�˲�
X=rec; % �����ź�(�Ѿ�ȡ��)
L=1;   % ������Ϊ2*L��,��2*L+1����ͷ,�ı�B����ĳ��ȼ��ı��˾������ļ���
B=[zeros(1,L), 1 ,zeros(1,L)]; % ��������ʼϵ��
adjstep=0.01; % ��������
% ����Ӧ�˲�����������������ź�, �������ĳ�ʼϵ���Լ����������й�
M=length(B);  % ��¼��������ͷ��
N=length(X);  % ��¼�����źŵĳ���
bb(N-M+1,1:length(B))=0; %���ڼ�¼������ϵ���仯�Ĵ洢����
for k=1:N-M+1;                     % ���Ƽ�������Ӧ�˲���ϵ��
   y(k)=sum(X(k:k+M-1).*fliplr(B));% �˲���� 
   XK=X(k:k+M-1);                  % �����˲�������ʱ����״̬
   ek=sign(y(k))-y(k);             % �о����γ����
   e(k)=ek;                        % ����������Ա���ͼ
   dlt=fliplr(XK).*ek.*adjstep;    % �γɷ���������
   B=B+dlt;                        % ���Ƶõ��µ��˲���ϵ��
   bb(k,:)=B;                      % ��¼ÿ�ε������õľ�������ͷϵ��
end
BB1=[bb(1900,:);zeros(9,2*L+1)];     % ϵ��ת������2����ǰ����ͨ�ŵ���
BB1=reshape(BB1,1,10*(2*L+1));       % ������Ϊ10KHz�ľ����˲���ϵ��
BBout1=filter(BB1,1,wavout) ;        % �����˲������(������Ӧ�˲����������ϵ��)
BB2=[B;zeros(9,2*L+1)];              % ϵ��ת������2���Ժ󣺶ྶ�ŵ���
BB2=reshape(BB2,1,10*(2*L+1));       % ������Ϊ10KHz�ľ����˲���ϵ��
BBout2=filter(BB2,1,wavout) ;        % �����˲������(������Ӧ�˲����������ϵ��)
%--��ӡ��������--
figure(1);plot(e);title('������� \epsilon_k');        % �������
figure(2);plot(bb);title('����Ӧ��������ͷϵ��c_j');   % �˲���ϵ���仯����
eyediagram(BBout1(15000:20000),20);  % ���������ͼ����2����ǰ����ͨ�ŵ���
eyediagram(BBout2(46001:50000),20);  % ���������ͼ����2���Ժ󣺶ྶ�ŵ���
eyediagram(wavout(10001:19000),20);  % ����ǰ����ͼ����2����ǰ��
eyediagram(wavout(46001:50000),20);  % ����ǰ����ͼ����2���Ժ�