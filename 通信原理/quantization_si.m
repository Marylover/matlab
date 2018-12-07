% quantization_sim.m
% Liu longwei in 2016.9.28, sunllw@163.com
%要求同学们比较均匀量化和非均匀量化量化信噪比的区别，并把理论值与实际测量值进行对比。
clc;
clear all;
close all; 

freq=1;     % 输入正弦波频率
AdB=-60:1:0;% 输入电平（分贝）
A=10.^(AdB./20);
for mu=[0.001, 255];% 均匀量化和非均匀量化情况
  for k=1:length(A)
     sourceAmp=A(k);         % 信号电平赋值
     sim('quantization_sim.mdl'); % 启动仿真模型
     SNR(k)=10*log10(SandN(2)./SandN(1));% 计算量化信噪比
 end
 plot(AdB,SNR,'o');hold on;drawnow; % 量化信噪比曲线
end
xlabel('输入信号电平 dB');ylabel('量化信噪比 dB');
axis([-60 0 0 50]);
% 理论计算结果：
SNR_dB=6*8+1.76+20*log10(A);
mu=255;
Q_dB=20*log10(mu/(log(1+mu)))-20*log10(1+mu*A);
SNR_dB_mulaw=SNR_dB+Q_dB;
plot(AdB,SNR_dB,'-',AdB,SNR_dB_mulaw,'--');