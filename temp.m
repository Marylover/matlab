%《数字信号处理--原理、实现及应用》第二章 例2.5.2 图2.5.2 绘制程序：ep252.m
% 电子工业出版社出版  高西全  丁玉美  阔永红合著 2006年8月
close all 
a=0.75;
B=[1,-1];A=[1,-a];zplane(B,A)
figure(2)
[Hk,w]=freqz(B,A,'whole');  %计算频响特性(a=0.95，N=1)
subplot(3,2,1);plot(w/pi,abs(Hk));
xlabel('\omega/\pi');axis([0,2,0,1.5]);title('(a)幅频特性(a=0.75,N=1)')
B=[1,0,0,0,-1];A=[1,0,0,0,-a]; 
[Hk,w]=freqz(B,A,'whole');  %计算频响特性(a=0.95，N=8)
subplot(3,2,2);plot(w/pi,abs(Hk));
xlabel('\omega/\pi');axis([0,2,0,1.5]);title('(b)幅频特性(a=0.75,N=4)')
B=[1,0,0,0,0,0,0,0,-1];A=[1,0,0,0,0,0,0,0,-a]; 
[Hk,w]=freqz(B,A,'whole');  %计算频响特性(a=0.95，N=8)
subplot(3,2,6);plot(w/pi,abs(Hk));
xlabel('\omega/\pi');axis([0,2,0,1.5]);title('(c)幅频特性(a=0.75,N=8)')
figure(3);zplane(B,A)
