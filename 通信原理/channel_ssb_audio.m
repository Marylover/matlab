% channel_ssb_audio.m
function out=channel_ssb_audio(in, SNRdB)
% SNR_dB �趨�����
% in �����ź�����
% out �ŵ��������
Fs=50000; %ϵͳ������
Power_of_in=var(in);
Power_of_noise=Power_of_in/(10.^(SNRdB/10));
bandwidth=13500-10000;        % �ŵ�����
N0=Power_of_noise/bandwidth;  % �����������ܶ�ֵW/Hz
Gauss_noise=sqrt(N0*Fs/2).*randn(size(in));
[num, den]=butter(4, [10000 13500]/(Fs/2)); % ��ͨ�ŵ�10KHz��13.5KHz
signal_of_filter_out=filter(num, den, in);
noise_of_filter_out=filter(num, den, Gauss_noise);
SNR_dB=10*log10(var(signal_of_filter_out)/var(noise_of_filter_out)) 
% �����ó��������
out=signal_of_filter_out+noise_of_filter_out; % �ŵ����