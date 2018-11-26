%created by ICTBeginner 2018 11 20
function [y,t] = waveGen(F,type)
%生成给定频率的波形
%F,频率;type = 0,正弦波;type = 1 方波; 
A = 50; %幅值
fs = 64*F; %采样频率
N = 500000;
dt = 1/fs;
t = 0:dt:(N-1)*dt; %时间向量
sourceType = type;
switch sourceType
    case 0 
        y = A*sin(2*pi*F*t);
    case 1
        y = A*square(2*pi*F*t,50);
    otherwise
end
end

