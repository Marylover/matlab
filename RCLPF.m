close all;
f=1:5:30000;%频率序列
w=2*pi*f;
R=100;%电阻值
C=1e-6;%电容值
for m=1:length(f)
    Zc(m)=1/(2*pi*w(m)*C);%电容阻抗
end
plot(f,Zc);
title('电容阻抗');
Fc=1/(2*pi*R*C);%截止频率
Para=R*C*i;
for n=1:length(f)
    A(n)=abs(1/(1+Para*w(n)));%幅值衰减系数
    P(n)=angle(1/(1+Para*w(n))) * 180 / pi;%相移系数
end
figure;
subplot(2,1,1);
plot(f,A,'r');%幅值曲线
title('幅值衰减特性');
subplot(2,1,2);
plot(f,P,'blue');%相位曲线
title('相位特性');
% %频域分析
% Func=tf(1,[R*C,1]);%系统的传递函数
% figure;
% subplot(2,1,1);
% bode(Func);%系统的伯德图
% title('伯德图');
% subplot(2,1,2);
% nyquist(Func);%系统的奈氏图
% title('奈氏图');
% %使用lsim进行信号仿真并使用FFT进行分析
% figure;
% F1=0.1;
% F2=100;
% F3=1000;
% F4=2000;
% F5=300;
% %
% Fs=10000;%采样率
% N=20000;%采样点数
% n=0:N-1;
% t=n/Fs;%时间序列
% f=n*Fs/N;%频率序列
% %
% SigIn=sin(2*pi*F1*t)+5*sin(2*pi*F2*t)+10*sin(2*pi*F3*t)+30*sin(2*pi*F4*t)+2*sin(2*pi*F5*t);%原始信号
% [SigOut,Tr] = lsim(Func,SigIn,t);%滤波后信号图像
% subplot(2,1,1);
% plot(t,SigIn);
% title('原始信号');
% subplot(2,1,2);
% plot(Tr,SigOut);
% title('滤波后的信号');
% %傅里叶变换分析滤波前的信号
% sigInFFT = fft(SigIn,N);%FFT变换
% %幅值特性
% sigInAmp = abs(sigInFFT) * 2 / N;
% sigInAmp(1) = sigInAmp(1) / 2;
% %相位特性
% sigInPhase = angle(sigInFFT) * 180 / pi;
% figure;
% subplot(2,1,1);
% plot(f,sigInAmp);
% title('原始信号幅值特性');
% subplot(2,1,2);
% plot(f,sigInPhase);
% title('原始信号相位特性');
% %傅里叶变换分析滤波后的信号
% sigOutFFT = fft(SigOut,N);%FFT变换
% %幅值特性
% sigOutAmp = abs(sigOutFFT) * 2 / N;
% sigOutAmp(1) = sigOutAmp(1) / 2;
% %相位特性
% sigOutPhase = angle(sigOutFFT) * 180 / pi;
% figure;
% subplot(2,1,1);
% plot(f,sigOutAmp);
% title('输出信号幅值特性');
% subplot(2,1,2);
% plot(f,sigOutPhase);
% title('输出信号相位特性');