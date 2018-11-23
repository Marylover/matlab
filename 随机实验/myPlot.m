function [  ] = myPlot( num,t,x,F,str,key)
%画出输入信号的时域，频域波形
%num: 图形序号 t: 时间序列 x : 幅值序列 
%F : 频率 str: 图片标题相关信息 key : 0代表未滤波，1代表已滤波
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
title([str,' ','时域未滤波波形'])
saveas(gcf, [str,' ','时域未滤波波形'], 'jpg');
else 
   title([str,' ','时域已滤波波形'])
   saveas(gcf, [str,' ','时域已滤波波形'], 'jpg');
end 
if key == 0
figure(num*2);
else 
  figure(num*20)
end
fftAndPlot( x,F );
if key == 0
title([str,' ','频域未滤波波形'])
saveas(gcf, [str,' ','频域未滤波波形'], 'jpg');
else 
   title([str,' ','频域已滤波波形'])
   saveas(gcf, [str,' ','频域已滤波波形'], 'jpg');
end
if key == 0
figure(num*3);
else 
  figure(num*30)
end
xcorrAndPlot(x,F);
if key == 0
title([str,' ','未滤波信号自相关'])
saveas(gcf,[str,' ','未滤波信号自相关'], 'jpg');
else 
   title([str,' ','已滤波信号自相关'])
   saveas(gcf,[str,' ','已滤波信号自相关'], 'jpg');
   
end
if key == 0
figure(num*4);
else 
  figure(num*40)
end
 conjAndPlot(x,F);
if key == 0
title([str,' ','未滤波信号功率谱'])
saveas(gcf,[str,' ','未滤波信号功率谱'], 'jpg');
else 
   title([str,' ','已滤波信号功率谱'])
   saveas(gcf,[str,' ','已滤波信号功率谱'], 'jpg');
end 
end

