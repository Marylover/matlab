%created by ICTBeginner 2018 11 20
function[] = fftAndPlot( y,F )
%�������źŽ���fft����������Ƶ��
fs = F;
n = length(y);
x = fft(y);
Y = fftshift(x);
xshift = abs(Y)./n;
fshift = (-n/2:n/2-1)*(fs/n);

plot(fshift,xshift);
xlabel('Ƶ��/Hz');
xlim([-5000,5000]);
ylabel('��ֵ/V');
end

