%create by xian at 2018.11.26
%create for AM Signal Generation and Analysis
fs=3072000;  %����Ƶ��                      
N=5e+4;     %FFT����           
dt=1/fs;            % ʱ������fs���ʱ������̣����߱�⻬
t=0:dt:(N-1)*dt;    % ʱ��������fs���ʱ�䳤�ȱ��  %��ֹʱ��Ͳ���
Am=6;  %�����ź����
A0=8;  %ֱ��������ֵ
Ac=1;   %�ز��ź����
fm=1e+5;  %�����ź�Ƶ��
fc=5e+5;  %�ز��ź�Ƶ��
Um=Am*cos(2*pi*fm*t);     %�����ź�
Ui=A0+Am*cos(2*pi*fm*t);  %��ֱ�������ĵ����ź�
Uc=Ac*cos(2*pi*fc*t);     %�ز��ź�
Uam=Ui.*Uc;               %AM�ѵ��ź�

figure(1);
subplot(2,1,1);
plot(t,Um);
xlabel('t(s)'),ylabel('��ֵ(V)'),title('�����ź�ʱ����');
xlim([0,1/fm*10]);
set(gca,'YTick', [-10 :2 :10]);

subplot(2,1,2);
Smw=fft(Um,N)*2/N;  %�Ե����źŽ��и���Ҷ�任
Umw=abs(fftshift(Smw));
f=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(f,Umw);  
ylim([0,10]);
xlabel('f(Hz)'),ylabel('��ֵ(V)'),title('�����ź�Ƶ��');

figure(2)
subplot(2,1,1);
plot(t,Uc);
xlim([0,1/fc*20]);
ylim([-2,2]);
xlabel('t(s)'),ylabel('��ֵ(V)'),title('�ز��ź�ʱ����'); 

subplot(2,1,2);
Scw=fft(Uc,N)*2/N;  %���ز��źŽ��и���Ҷ�任
Ucw=abs(fftshift(Scw));
f=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(f,Ucw);  
ylim([0,2]);
xlabel('f(Hz)'),ylabel('��ֵ(V)'),title('�ز��ź�Ƶ��');

figure(3)
subplot(2,1,1);
plot(t,Ui);
xlim([0,1/fm*10]);
ylim([0,16]);
xlabel('t(s)'),ylabel('��ֵ(V)'),title('��ֱ������������ź�ʱ����'); 

subplot(2,1,2);
Siw=fft(Ui,N)*2/N;  %�Լ�ֱ������������źŽ��и���Ҷ�任
Uiw=abs(fftshift(Siw));
f=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(f,Uiw);  
ylim([0,20]);
xlabel('f(Hz)'),ylabel('��ֵ(V)'),title('��ֱ������������ź��ź�Ƶ��');

figure(4)
subplot(2,1,1);
plot(t,Uam);
xlim([0,1/fm*10]);
xlabel('t(s)'),ylabel('��ֵ(V)'),title('AM�ź�ʱ����'); 

subplot(2,1,2);
Samw=fft(Uam,N)*2/N;  %��AM�źŽ��и���Ҷ�任
Uamw=abs(fftshift(Samw));
f=(-N/2:1:N/2-1)*fs/N; %˫��  
plot(f,Uamw);  
ylim([0,10]);
set(gca,'YTick', [0 :2 :10]);
xlabel('f(Hz)'),ylabel('��ֵ(V)'),title('AM�ź�Ƶ��');

figure(5)
yn=awgn(Uam,6);           %�����˹������
subplot(2,1,1)
plot(t,yn)
xlim([0,1/fm*10]);
xlabel('t(s)'),ylabel('��ֵ(V)'),title('����AM�źŲ���');
fyn=fft(yn,N)*2/N;%����ɢ����Ҷ
mag=abs(fftshift(fyn));

subplot(2,1,2)
plot(f,mag)
ylim([0,10]);
set(gca,'YTick', [0 :2 :10]);
xlabel('f(Hz)'),ylabel('��ֵ(V)'),title('����AM�ź�Ƶ��')

figure(6)
%[r,lags]=xcorr(yn,'unbiased');  %����AM�źŵ������
[Rx,maxlags]=xcorr(yn,'unbiased');  %�źŵ������
if fs>10000  %����ʱ���ᵥλ����ǩ,���ڹ۲Ⲩ��
    plot(maxlags/fs*1000,Rx/max(Rx));
    xlabel('ʱ�Ӳ�/ms');
else
    plot(maxlags/fs,Rx/max(Rx));
    xlabel('ʱ�Ӳ�/s');
end
ylim([-1,1]);
plot(maxlags/fs,Rx/max(Rx));
ylabel('R(��)');
title('����AM�ź�ʱ���ε�����غ���')
xlim([-1/fm*5,1/fm*5])
%ylim([-0.5,0.5]);

disp('AM�ź�ʱ���εľ�ֵΪ');
En1=mean(Uam);                         % ��AM�ź�ʱ���εľ�ֵ
disp(En1); 
disp('AM�ź�ʱ���εķ���Ϊ');
Dn1=var(Uam);                          % ��AM�ź�ʱ���εķ���
disp(Dn1);
disp('����AM�ź�ʱ���εľ�ֵΪ');
En2=mean(yn);                         % �����AM�ź�ʱ���εľ�ֵ
disp(En2); 
disp('����AM�ź�ʱ���εķ���Ϊ');
Dn2=var(yn);                          % �����AM�ź�ʱ���εķ���
disp(Dn2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CH1_data=Um;
CH2_data=Uc;
gain_flag=1;
divFreq=30720000/fs-1;
dataNum=length(CH1_data);
DA_OUT(CH1_data,CH2_data,divFreq,dataNum, gain_flag);
