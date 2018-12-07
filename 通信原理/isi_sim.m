%isi_sim.m
% Liu longwei in 2016.9.25, sunllw@163.com
clc
clear all
close all

m=1000;%������еĳ��ȣ�����ѧ�ź���λ����λ��
y1=randsrc(1,m);%���ɳ���Ϊm��1��-1�ȸų��ֵ������������

x1=[0.1 -0.25 1 -0.25 0.1];  %�ŵ�1��ϵͳ����
x2=[-0.2 0.5 1 0.5 -0.2];    %�ŵ�2��ϵͳ����

y11=conv(y1,x1); %�����ź�ͨ���ŵ�һ��ISI����
y12=conv(y1,x2); %����ʼ�ź�ͨ���ŵ�����ISI����
figure(1)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y11,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('�����ź�ͨ���ŵ�һ��ISI����');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y12,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('�����ź�ͨ���ŵ�����ISI����')

noise1=normrnd(1.5,0,1,length(y11)); %���ɾ�ֵΪ0.5������Ϊ0�ĸ�˹������ֱ��������
y21=y11+noise1;   %�ŵ�һISI���μ���0��������
y22=y12+noise1;   %�ŵ���ISI���μ���0��������
figure(2)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y21,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('�ŵ�һISI���μ���0��������');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y22,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                   
title('�ŵ���ISI���μ���0��������')

noise2=normrnd(1.5,0.1,1,length(y11)); %���ɾ�ֵΪ0.5������Ϊ0.1�ĸ�˹����
y31=y11+noise2;   %�ŵ�һISI���μ���0.1��������
y32=y12+noise2;   %�ŵ���ISI���μ���0.1��������
figure(3)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y31,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                
title('�ŵ�һISI���μ���0.1��������');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y32,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                
title('�ŵ���ISI���μ���0.1��������')          

eyediagram(y1,2);         %ԭʼ�ź���ͼ
title('ԭʼ�ź���ͼ');

eyediagram(y11,2);         %�ŵ�һISI��ͼ
title('�ŵ�һ������ISI��ͼ');
hold on;
eyediagram(y12,2);         %�ŵ���ISI��ͼ
title('�ŵ���������ISI��ͼ');
hold on;

eyediagram(y21,2); 
title('�ŵ�һISI��0������������ͼ'); %�ŵ�һISI���μ���0����������ͼ
hold on
eyediagram(y22,2); 
title('�ŵ���ISI��0������������ͼ'); %�ŵ���ISI���μ���0����������ͼ
hold on

eyediagram(y31,2); 
title('�ŵ�һISI��0.1������������ͼ'); %�ŵ�һISI���μ���0.1����������ͼ
hold on
eyediagram(y32,2); 
title('�ŵ���ISI��0.1������������ͼ'); %�ŵ���ISI���μ���0.1����������ͼ
hold on


