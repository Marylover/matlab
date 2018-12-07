%isi_sim.m
% Liu longwei in 2016.9.25, sunllw@163.com
clc
clear all
close all

m=1000;%随机序列的长度，请用学号后四位或五位。
y1=randsrc(1,m);%生成长度为m，1，-1等概出现的随机输入序列

x1=[0.1 -0.25 1 -0.25 0.1];  %信道1的系统函数
x2=[-0.2 0.5 1 0.5 -0.2];    %信道2的系统函数

y11=conv(y1,x1); %输入信号通过信道一的ISI波形
y12=conv(y1,x2); %输入始信号通过信道二的ISI波形
figure(1)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y11,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('输入信号通过信道一的ISI波形');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y12,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('输入信号通过信道二的ISI波形')

noise1=normrnd(1.5,0,1,length(y11)); %生成均值为0.5，方差为0的高斯噪声（直流噪声）
y21=y11+noise1;   %信道一ISI波形加入0方差噪声
y22=y12+noise1;   %信道二ISI波形加入0方差噪声
figure(2)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y21,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                    
title('信道一ISI波形加入0方差噪声');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y22,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                   
title('信道二ISI波形加入0方差噪声')

noise2=normrnd(1.5,0.1,1,length(y11)); %生成均值为0.5，方差为0.1的高斯噪声
y31=y11+noise2;   %信道一ISI波形加入0.1方差噪声
y32=y12+noise2;   %信道二ISI波形加入0.1方差噪声
figure(3)
subplot(2,1,1)
stem(y1,'bo')
hold on
stem(y31,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                
title('信道一ISI波形加入0.1方差噪声');
subplot(2,1,2)
stem(y1,'bo')
hold on
stem(y32,'gv')
axis([1,100,-1.5,1.5])
grid on
hold on                
title('信道二ISI波形加入0.1方差噪声')          

eyediagram(y1,2);         %原始信号眼图
title('原始信号眼图');

eyediagram(y11,2);         %信道一ISI眼图
title('信道一无噪声ISI眼图');
hold on;
eyediagram(y12,2);         %信道二ISI眼图
title('信道二无噪声ISI眼图');
hold on;

eyediagram(y21,2); 
title('信道一ISI在0方差噪声下眼图'); %信道一ISI波形加入0方差噪声眼图
hold on
eyediagram(y22,2); 
title('信道二ISI在0方差噪声下眼图'); %信道二ISI波形加入0方差噪声眼图
hold on

eyediagram(y31,2); 
title('信道一ISI在0.1方差噪声下眼图'); %信道一ISI波形加入0.1方差噪声眼图
hold on
eyediagram(y32,2); 
title('信道二ISI在0.1方差噪声下眼图'); %信道二ISI波形加入0.1方差噪声眼图
hold on


