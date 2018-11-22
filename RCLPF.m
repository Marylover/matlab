close all;
f=1:5:30000;%Ƶ������
w=2*pi*f;
R=100;%����ֵ
C=1e-6;%����ֵ
for m=1:length(f)
    Zc(m)=1/(2*pi*w(m)*C);%�����迹
end
plot(f,Zc);
title('�����迹');
Fc=1/(2*pi*R*C);%��ֹƵ��
Para=R*C*i;
for n=1:length(f)
    A(n)=abs(1/(1+Para*w(n)));%��ֵ˥��ϵ��
    P(n)=angle(1/(1+Para*w(n))) * 180 / pi;%����ϵ��
end
figure;
subplot(2,1,1);
plot(f,A,'r');%��ֵ����
title('��ֵ˥������');
subplot(2,1,2);
plot(f,P,'blue');%��λ����
title('��λ����');
% %Ƶ�����
% Func=tf(1,[R*C,1]);%ϵͳ�Ĵ��ݺ���
% figure;
% subplot(2,1,1);
% bode(Func);%ϵͳ�Ĳ���ͼ
% title('����ͼ');
% subplot(2,1,2);
% nyquist(Func);%ϵͳ������ͼ
% title('����ͼ');
% %ʹ��lsim�����źŷ��沢ʹ��FFT���з���
% figure;
% F1=0.1;
% F2=100;
% F3=1000;
% F4=2000;
% F5=300;
% %
% Fs=10000;%������
% N=20000;%��������
% n=0:N-1;
% t=n/Fs;%ʱ������
% f=n*Fs/N;%Ƶ������
% %
% SigIn=sin(2*pi*F1*t)+5*sin(2*pi*F2*t)+10*sin(2*pi*F3*t)+30*sin(2*pi*F4*t)+2*sin(2*pi*F5*t);%ԭʼ�ź�
% [SigOut,Tr] = lsim(Func,SigIn,t);%�˲����ź�ͼ��
% subplot(2,1,1);
% plot(t,SigIn);
% title('ԭʼ�ź�');
% subplot(2,1,2);
% plot(Tr,SigOut);
% title('�˲�����ź�');
% %����Ҷ�任�����˲�ǰ���ź�
% sigInFFT = fft(SigIn,N);%FFT�任
% %��ֵ����
% sigInAmp = abs(sigInFFT) * 2 / N;
% sigInAmp(1) = sigInAmp(1) / 2;
% %��λ����
% sigInPhase = angle(sigInFFT) * 180 / pi;
% figure;
% subplot(2,1,1);
% plot(f,sigInAmp);
% title('ԭʼ�źŷ�ֵ����');
% subplot(2,1,2);
% plot(f,sigInPhase);
% title('ԭʼ�ź���λ����');
% %����Ҷ�任�����˲�����ź�
% sigOutFFT = fft(SigOut,N);%FFT�任
% %��ֵ����
% sigOutAmp = abs(sigOutFFT) * 2 / N;
% sigOutAmp(1) = sigOutAmp(1) / 2;
% %��λ����
% sigOutPhase = angle(sigOutFFT) * 180 / pi;
% figure;
% subplot(2,1,1);
% plot(f,sigOutAmp);
% title('����źŷ�ֵ����');
% subplot(2,1,2);
% plot(f,sigOutPhase);
% title('����ź���λ����');