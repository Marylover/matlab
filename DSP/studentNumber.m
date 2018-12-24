info = audioinfo('syd.m4a')  %获取当前语音信号文件的信息
[y,Fs] = audioread('syd.m4a'); %y为信号序列，Fs为采样频率（注意不是频率）
%sound(y,Fs);
t=(0:length(y)-1)/Fs;
figure(1)
plot(y)
xlabel('Time')
ylabel('Audio Signal')
title('未加噪时域波形')
figure(2);
ssap(y,Fs);
title('未加噪单边谱')


% % % 巴特沃斯低通滤波器
% fc = 1000;
% [b,a] = butter(6,fc/(Fs/2));
% figure(3);
% [h,f]=freqz(b,a);
% plot(f*Fs/(2*pi),20*log10(abs(h)))
% xlabel('频率/Hz')
% ylabel('增益/dB')
% xlim([0,3000])
% title('巴特沃斯滤波器损耗函数')


% % % fir 低通滤波器
wp=800*2/Fs;% 频率归一化
ws=1200*2/Fs;
wdel=ws-wp;% 过渡带宽
wn=0.5*(wp+ws);% 近似计算截止频率
N=ceil(6.6*pi/wdel);% 根据过渡带宽度求滤波器阶数
window=hamming(N+1);% 海明窗
b=fir1(N,wn,window);% FIR滤波器设计
[h1,f1]=freqz(b,1,512);% 查看滤波器幅频及相频特性 
figure(6);
plot(f1*Fs/(2*pi),20*log10(abs(h1)))
xlabel('频率/Hz')
ylabel('增益/dB')
xlim([0,3000])
title('fir滤波器损耗函数')


%%% 加噪
noise = 0.5*sin(2*pi*2000*t);
ys = y + [noise',zeros(length(noise),1)];
sound(ys,Fs);
figure(7);
ssap(ys,Fs);
xlim([0,2500]);
title('加噪后单边谱');
figure(8);
plot(ys);
title('加噪后时域波形');

%%%滤波
dataout = filter(b,1,y);
figure(4);
ssap(dataout,Fs);
title('已滤波单边谱')
xlim([0,2500]);
figure(5);
plot(dataout);
title('已滤波时域波形')

%sound(dataout,Fs);
