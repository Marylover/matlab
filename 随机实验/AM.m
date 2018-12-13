%create by xian at 2018.11.26
%create for AM Signal Generation and Analysis
fs=3072000;  %抽样频率                      
N=5e+4;     %FFT长度           
dt=1/fs;            % 时间间隔，fs变大，时间间隔变短，曲线变光滑
t=0:dt:(N-1)*dt;    % 时间向量，fs变大，时间长度变短  %截止时间和步长
Am=6;  %调制信号振幅
A0=8;  %直流分量幅值
Ac=1;   %载波信号振幅
fm=1e+5;  %调制信号频率
fc=5e+5;  %载波信号频率
Um=Am*cos(2*pi*fm*t);     %调制信号
Ui=A0+Am*cos(2*pi*fm*t);  %加直流分量的调制信号
Uc=Ac*cos(2*pi*fc*t);     %载波信号
Uam=Ui.*Uc;               %AM已调信号

figure(1);
subplot(2,1,1);
plot(t,Um);
xlabel('t(s)'),ylabel('幅值(V)'),title('调制信号时域波形');
xlim([0,1/fm*10]);
set(gca,'YTick', [-10 :2 :10]);

subplot(2,1,2);
Smw=fft(Um,N)*2/N;  %对调制信号进行傅里叶变换
Umw=abs(fftshift(Smw));
f=(-N/2:1:N/2-1)*fs/N; %双边  
plot(f,Umw);  
ylim([0,10]);
xlabel('f(Hz)'),ylabel('幅值(V)'),title('调制信号频谱');

figure(2)
subplot(2,1,1);
plot(t,Uc);
xlim([0,1/fc*20]);
ylim([-2,2]);
xlabel('t(s)'),ylabel('幅值(V)'),title('载波信号时域波形'); 

subplot(2,1,2);
Scw=fft(Uc,N)*2/N;  %对载波信号进行傅里叶变换
Ucw=abs(fftshift(Scw));
f=(-N/2:1:N/2-1)*fs/N; %双边  
plot(f,Ucw);  
ylim([0,2]);
xlabel('f(Hz)'),ylabel('幅值(V)'),title('载波信号频谱');

figure(3)
subplot(2,1,1);
plot(t,Ui);
xlim([0,1/fm*10]);
ylim([0,16]);
xlabel('t(s)'),ylabel('幅值(V)'),title('加直流分量后调制信号时域波形'); 

subplot(2,1,2);
Siw=fft(Ui,N)*2/N;  %对加直流分量后调制信号进行傅里叶变换
Uiw=abs(fftshift(Siw));
f=(-N/2:1:N/2-1)*fs/N; %双边  
plot(f,Uiw);  
ylim([0,20]);
xlabel('f(Hz)'),ylabel('幅值(V)'),title('加直流分量后调制信号信号频谱');

figure(4)
subplot(2,1,1);
plot(t,Uam);
xlim([0,1/fm*10]);
xlabel('t(s)'),ylabel('幅值(V)'),title('AM信号时域波形'); 

subplot(2,1,2);
Samw=fft(Uam,N)*2/N;  %对AM信号进行傅里叶变换
Uamw=abs(fftshift(Samw));
f=(-N/2:1:N/2-1)*fs/N; %双边  
plot(f,Uamw);  
ylim([0,10]);
set(gca,'YTick', [0 :2 :10]);
xlabel('f(Hz)'),ylabel('幅值(V)'),title('AM信号频谱');

figure(5)
yn=awgn(Uam,6);           %加入高斯白噪声
subplot(2,1,1)
plot(t,yn)
xlim([0,1/fm*10]);
xlabel('t(s)'),ylabel('幅值(V)'),title('加噪AM信号波形');
fyn=fft(yn,N)*2/N;%做离散傅里叶
mag=abs(fftshift(fyn));

subplot(2,1,2)
plot(f,mag)
ylim([0,10]);
set(gca,'YTick', [0 :2 :10]);
xlabel('f(Hz)'),ylabel('幅值(V)'),title('加噪AM信号频谱')

figure(6)
%[r,lags]=xcorr(yn,'unbiased');  %加噪AM信号的自相关
[Rx,maxlags]=xcorr(yn,'unbiased');  %信号的自相关
if fs>10000  %调整时间轴单位及标签,便于观测波形
    plot(maxlags/fs*1000,Rx/max(Rx));
    xlabel('时延差/ms');
else
    plot(maxlags/fs,Rx/max(Rx));
    xlabel('时延差/s');
end
ylim([-1,1]);
plot(maxlags/fs,Rx/max(Rx));
ylabel('R(τ)');
title('加噪AM信号时域波形的自相关函数')
xlim([-1/fm*5,1/fm*5])
%ylim([-0.5,0.5]);

disp('AM信号时域波形的均值为');
En1=mean(Uam);                         % 求AM信号时域波形的均值
disp(En1); 
disp('AM信号时域波形的方差为');
Dn1=var(Uam);                          % 求AM信号时域波形的方差
disp(Dn1);
disp('加噪AM信号时域波形的均值为');
En2=mean(yn);                         % 求加噪AM信号时域波形的均值
disp(En2); 
disp('加噪AM信号时域波形的方差为');
Dn2=var(yn);                          % 求加噪AM信号时域波形的方差
disp(Dn2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CH1_data=Um;
CH2_data=Uc;
gain_flag=1;
divFreq=30720000/fs-1;
dataNum=length(CH1_data);
DA_OUT(CH1_data,CH2_data,divFreq,dataNum, gain_flag);
