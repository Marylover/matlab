%created by ICTBeginner 2018 11 20
function[] = fftAndPlot( y,F )
%�������źŽ���fft����������Ƶ��
N =503807;
fs = F;
freq=fft(y,N)*2/N;%����ɢ����Ҷ
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(w,freq_d);
xlabel('Ƶ��/Hz');
ylabel('��ֵ/V');
end

