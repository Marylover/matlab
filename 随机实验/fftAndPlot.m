function[] = fftAndPlot( y,F )
%�������źŽ���fft����������Ƶ��
N = 50000;
fs = 10*F;
freq=fft(y,N)*2/N;%����ɢ����Ҷ
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %˫��  
ylim([0,60]);
plot(w,freq_d);
xlabel('Ƶ��/Hz');
ylabel('��ֵ/V');
end

