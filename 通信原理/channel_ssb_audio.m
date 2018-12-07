% channel_ssb_audio.m
function out=channel_ssb_audio(in, SNRdB)
% SNR_dB 设定信噪比
% in 输入信号序列
% out 信道输出序列
Fs=50000; %系统采样率
Power_of_in=var(in);
Power_of_noise=Power_of_in/(10.^(SNRdB/10));
bandwidth=13500-10000;        % 信道带宽
N0=Power_of_noise/bandwidth;  % 噪声功率谱密度值W/Hz
Gauss_noise=sqrt(N0*Fs/2).*randn(size(in));
[num, den]=butter(4, [10000 13500]/(Fs/2)); % 带通信道10KHz到13.5KHz
signal_of_filter_out=filter(num, den, in);
noise_of_filter_out=filter(num, den, Gauss_noise);
SNR_dB=10*log10(var(signal_of_filter_out)/var(noise_of_filter_out)) 
% 测量得出的信噪比
out=signal_of_filter_out+noise_of_filter_out; % 信道输出