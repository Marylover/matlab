function [] = xcorrAndPlot(y,F)
%���㺯������ز���ͼ
%�ź������
fs = 10*F;
[Rx,maxlags]=xcorr(y,'unbiased');  %�źŵ������
plot(maxlags/fs,Rx/max(Rx));
xlabel('ʱ�Ӳ�/s');
ylabel('R(��)');
xlim([-1/F*10,1/F*10])
ylim([-1,1]);
end

