info = audioinfo('syd.m4a')  %获取当前语音信号文件的信息
[y,Fs] = audioread('syd.m4a'); %y为信号序列，Fs为采样频率（注意不是频率）
t = 0:seconds(1/Fs):seconds(info.Duration); 
t = t(1:end);
figure(1)
plot(y)
xlabel('Time')
ylabel('Audio Signal')
L = length(y);
Y = fft(y);
P2 = abs(Y).^2/L;
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = (Fs/L)*(0:(L/2));
figure(2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0,1000])

fc = 200;
fs = 500;
[b,a] = butter(6,fc/(fs/2));
freqz(b,a);
dataout = filter(b,a,y);

