%create by ICTBeginner 2018 11 20
function[] = fftAndPlot( y,F )
%对输入信号进行fft并画出它的频谱
N = 50000;
fs = 64*F;
freq=fft(y,N)*2/N;%做离散傅里叶
freq_d=abs(fftshift(freq));
w=(-N/2:1:N/2-1)*fs/N; %双边  
plot(w,freq_d);
xlabel('频率/Hz');
ylabel('幅值/V');
ylim([0,60]);
set(gca,'YTick', [0 :10 :60]);
end

