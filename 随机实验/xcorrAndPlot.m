%created by ICTBeginner 2018 11 20
function [] = xcorrAndPlot(y,F)
%计算函数自相关并绘图
%信号自相关
fs = 64*F;
[Rx,maxlags]=xcorr(y,'unbiased');  %信号的自相关
plot(maxlags/fs,Rx/max(Rx));
xlabel('时延差/s');
ylabel('R(τ)');
xlim([-1/F*10,1/F*10])
ylim([-1,1]);
end

