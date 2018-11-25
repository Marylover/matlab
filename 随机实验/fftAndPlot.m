%create by ICTBeginner 2018 11 20
function[] = fftAndPlot( y,F )
%�������źŽ���fft����������Ƶ��
N = 50000;
fs = 64*F;
freq=fft(y,N)*2/N;%����ɢ����Ҷ
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(w,freq_d);
xlabel('Ƶ��/Hz');
ylabel('��ֵ/V');
ylim([0,60]);
set(gca,'YTick', [0 :10 :60]);
end

