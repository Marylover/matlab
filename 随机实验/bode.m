%created by ICTBeginner 2018 11 20
%������
R = 100;
C = 1e-7;
a = R*C;
figure(11);
fc = 1/(2*pi*a);
sys = tf(1,[a,1]);
bode(sys);
title('��Ƶ��Ƶ��Ӧ')
grid on
%����ͨ��Ƶ�� 1k,5k,15k
[x1,t1] = waveGen(1e3,0);
myPlot( 1,t1,x1,1e3,'Ƶ��1kHz���Ҳ�',0);
[x2,t2] = waveGen(5e3,0);
myPlot( 2,t2,x2,5e3,'Ƶ��5kHz���Ҳ�',0);
[x3,t3] = waveGen(1.5e4,0);
myPlot( 3,t3,x3,15e3,'Ƶ��15kHz���Ҳ�',0);
%�������ɴ�Ƶ�� 16k,50k,120k
[x4,t4] = waveGen(1.6e4,0);
myPlot( 4,t4,x4,16e3,'Ƶ��16kHz���Ҳ�',0);
[x5,t5] = waveGen(5e4,0);
myPlot( 5,t5,x5,50e3,'Ƶ��50kHz���Ҳ�',0);
[x6,t6] = waveGen(1.2e5,0);
myPlot( 6,t6,x6,1.2e5,'Ƶ��120kHz���Ҳ�',0);
%�������Ƶ�� 167k, 170k , 200k
[x7,t7] = waveGen(1.67e5,0);
myPlot( 7,t7,x7,1.67e5,'Ƶ��167kHz���Ҳ�',0);
[x8,t8] = waveGen(1.7e5,0);
myPlot( 8,t8,x8,1.7e5,'Ƶ��170kHz���Ҳ�',0);
[x9,t9] = waveGen(2e5,0);
myPlot( 9,t9,x9,2e5,'Ƶ��200kHz���Ҳ�',0);
%һ��Ƶ��Ϊ10k�ķ���
[x10,t10] = waveGen(1e4,1);
myPlot( 10,t10,x10,1e4,'Ƶ��10kHz����',0);
% zh = c2d(sys,1e-5,'zoh'); %s��ת����z��
% [z1,z2] = tfdata(zh,'v');
% y10 = filter(z1,z2,x10);
% figure(2);
% plot(t10,y10);
% xlim([0,1e-3]);
%%%%%%%%%%%%%%%
[y1,~] = lsim(sys,x1,t1);
myPlot( 1,t1,y1,1e3,'Ƶ��1kHz���Ҳ�',1);
[y2,~] = lsim(sys,x2,t2);
myPlot( 2,t2,y2,5e3,'Ƶ��5kHz���Ҳ�',1);
[y3,~] = lsim(sys,x3,t3);
myPlot( 3,t3,y3,15e3,'Ƶ��15kHz���Ҳ�',1);
[y4,~] = lsim(sys,x4,t4);
myPlot( 4,t4,y4,16e3,'Ƶ��16kHz���Ҳ�',1);
[y5,~] = lsim(sys,x5,t5);
myPlot( 5,t5,y5,50e3,'Ƶ��50kHz���Ҳ�',1);
[y6,~] = lsim(sys,x6,t6);
myPlot( 6,t6,y6,1.2e5,'Ƶ��120kHz���Ҳ�',1);
[y7,~] = lsim(sys,x7,t7);
myPlot( 7,t7,y7,1.67e5,'Ƶ��167kHz���Ҳ�',1);
[y8,~] = lsim(sys,x8,t8);
myPlot( 8,t8,y8,1.7e5,'Ƶ��170kHz���Ҳ�',1);
[y9,~] = lsim(sys,x9,t9);
myPlot( 9,t9,y9,2e5,'Ƶ��200kHz���Ҳ�',1);
[y10,~] = lsim(sys,x10,t10);
myPlot( 10,t10,y10,1e4,'Ƶ��10kHz����',1);