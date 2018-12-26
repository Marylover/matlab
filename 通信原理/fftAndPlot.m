%created by ICTBeginner 2018 11 20
function[] = fftAndPlot( y,F )
%对输入信号进行fft并画出它的频谱
fs = F;
n = length(y);
x = fft(y);
Y = fftshift(x);
xshift = abs(Y)./n;
fshift = (-n/2:n/2-1)*(fs/n);

plot(fshift,xshift);
xlabel('频率/Hz');
xlim([-5000,5000]);
ylabel('幅值/V');
end

