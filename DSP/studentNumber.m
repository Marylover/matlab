info = audioinfo('studentNumber.m4a')  %��ȡ��ǰ�����ź��ļ�����Ϣ
[y,Fs] = audioread('studentNumber.m4a'); %yΪ�ź����У�FsΪ����Ƶ�ʣ�ע�ⲻ��Ƶ�ʣ�
t = 0:seconds(1/Fs):seconds(info.Duration); 
t = t(1:end);
figure(1)
plot(t,y)
xlabel('Time')
ylabel('Audio Signal')
L = length(y);
Y = fft(y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y0 = fftshift(Y);         % shift y values
f0 = (-L/2:L/2-1)*(Fs/L); % 0-centered frequency range
power0 = abs(y0)*2/L;    % 0-centered power
figure(3)
plot(f0,power0)
xlabel('Frequency')
ylabel('Power')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4)
fftAndPlot(y,Fs); %ע��ԭ��FΪ�ź�Ƶ�ʣ����˴�Ϊ����Ƶ��
