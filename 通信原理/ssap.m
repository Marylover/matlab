%created by ICTBeginner 2018 12 24
function[] = ssap( X,Fs )
Y = fft(X);
L=length(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
%title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
xlim([0,1000])
ylabel('|P1(f)|')