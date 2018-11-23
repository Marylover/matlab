function [] = conjAndPlot(y,F)
%输入一个函数，计算它的功率谱并绘图
N = 50000;
fs = 64*F;
w=(-N/2:1:N/2-1)*fs/N;
freq=fft(y,N)*2/N;%做离散傅里叶
freq_d=abs(fftshift(freq));
ypsd=freq_d.*conj(freq_d);
plot(w,ypsd);
xlabel('频率/Hz');
ylabel('W/Hz')
end

