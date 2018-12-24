info = audioinfo('syd.m4a')  %��ȡ��ǰ�����ź��ļ�����Ϣ
[y,Fs] = audioread('syd.m4a'); %yΪ�ź����У�FsΪ����Ƶ�ʣ�ע�ⲻ��Ƶ�ʣ�
%sound(y,Fs);
t=(0:length(y)-1)/Fs;
figure(1)
plot(y)
xlabel('Time')
ylabel('Audio Signal')
title('δ����ʱ����')
figure(2);
ssap(y,Fs);
title('δ���뵥����')


% % % ������˹��ͨ�˲���
% fc = 1000;
% [b,a] = butter(6,fc/(Fs/2));
% figure(3);
% [h,f]=freqz(b,a);
% plot(f*Fs/(2*pi),20*log10(abs(h)))
% xlabel('Ƶ��/Hz')
% ylabel('����/dB')
% xlim([0,3000])
% title('������˹�˲�����ĺ���')


% % % fir ��ͨ�˲���
wp=800*2/Fs;% Ƶ�ʹ�һ��
ws=1200*2/Fs;
wdel=ws-wp;% ���ɴ���
wn=0.5*(wp+ws);% ���Ƽ����ֹƵ��
N=ceil(6.6*pi/wdel);% ���ݹ��ɴ�������˲�������
window=hamming(N+1);% ������
b=fir1(N,wn,window);% FIR�˲������
[h1,f1]=freqz(b,1,512);% �鿴�˲�����Ƶ����Ƶ���� 
figure(6);
plot(f1*Fs/(2*pi),20*log10(abs(h1)))
xlabel('Ƶ��/Hz')
ylabel('����/dB')
xlim([0,3000])
title('fir�˲�����ĺ���')


%%% ����
noise = 0.5*sin(2*pi*2000*t);
ys = y + [noise',zeros(length(noise),1)];
sound(ys,Fs);
figure(7);
ssap(ys,Fs);
xlim([0,2500]);
title('����󵥱���');
figure(8);
plot(ys);
title('�����ʱ����');

%%%�˲�
dataout = filter(b,1,y);
figure(4);
ssap(dataout,Fs);
title('���˲�������')
xlim([0,2500]);
figure(5);
plot(dataout);
title('���˲�ʱ����')

%sound(dataout,Fs);
