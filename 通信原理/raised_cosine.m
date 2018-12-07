% raised_cosine.m
% Liu longwei in 2016.9.28, sunllw@163.com
clc
clear all
close all

Fd=1e3;
Fs=Fd*10;
delay=5;
for r=[0, 0.5, 0.75, 1]
    num = rcosine(Fd,Fs, 'fir/normal',r,delay);
    t=0:1/Fs:1/Fs*(length(num)-1);
    k=[rand(),rand(),rand()];%每个循环改变一次RGB颜色
    figure(1); plot(t,num,'Color',k); axis([0 0.01 -0.3 1.1]);hold on;
    Hw=abs(fft(num,1000));
    f=(1:Fs/1000:Fs)-1;
    figure(2); plot(f,Hw,'Color',k); axis([0 1500 0 12]);hold on;
end