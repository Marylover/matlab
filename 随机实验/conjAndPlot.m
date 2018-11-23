function [] = conjAndPlot(y,F)
%����һ���������������Ĺ����ײ���ͼ
N = 50000;
fs = 64*F;
w=(-N/2:1:N/2-1)*fs/N;
freq=fft(y,N)*2/N;%����ɢ����Ҷ
freq_d=abs(fftshift(freq));
ypsd=freq_d.*conj(freq_d);
plot(w,ypsd);
xlabel('Ƶ��/Hz');
ylabel('W/Hz')
end

