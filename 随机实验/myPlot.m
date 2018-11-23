function [  ] = myPlot( num,t,x,F,str,key)
%���������źŵ�ʱ��Ƶ����
%num: ͼ����� t: ʱ������ x : ��ֵ���� 
%F : Ƶ�� str: ͼƬ���������Ϣ key : 0����δ�˲���1�������˲�
if key == 0
figure(num);
else 
  figure(num*10)
end
plot(t,x);
xlim([0,1/F*10]);
ylim([-60,60]);
set(gca,'YTick', [-60 :10 :60])

if key == 0
title([str,' ','ʱ��δ�˲�����'])
saveas(gcf, [str,' ','ʱ��δ�˲�����'], 'jpg');
else 
   title([str,' ','ʱ�����˲�����'])
   saveas(gcf, [str,' ','ʱ�����˲�����'], 'jpg');
end 
if key == 0
figure(num*2);
else 
  figure(num*20)
end
fftAndPlot( x,F );
if key == 0
title([str,' ','Ƶ��δ�˲�����'])
saveas(gcf, [str,' ','Ƶ��δ�˲�����'], 'jpg');
else 
   title([str,' ','Ƶ�����˲�����'])
   saveas(gcf, [str,' ','Ƶ�����˲�����'], 'jpg');
end
if key == 0
figure(num*3);
else 
  figure(num*30)
end
xcorrAndPlot(x,F);
if key == 0
title([str,' ','δ�˲��ź������'])
saveas(gcf,[str,' ','δ�˲��ź������'], 'jpg');
else 
   title([str,' ','���˲��ź������'])
   saveas(gcf,[str,' ','���˲��ź������'], 'jpg');
   
end
if key == 0
figure(num*4);
else 
  figure(num*40)
end
 conjAndPlot(x,F);
if key == 0
title([str,' ','δ�˲��źŹ�����'])
saveas(gcf,[str,' ','δ�˲��źŹ�����'], 'jpg');
else 
   title([str,' ','���˲��źŹ�����'])
   saveas(gcf,[str,' ','���˲��źŹ�����'], 'jpg');
end 
end

