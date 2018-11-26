%created by ICTBeginner 2018 11 20
function [y,t] = waveGen(F,type)
%���ɸ���Ƶ�ʵĲ���
%F,Ƶ��;type = 0,���Ҳ�;type = 1 ����; 
A = 50; %��ֵ
fs = 64*F; %����Ƶ��
N = 500000;
dt = 1/fs;
t = 0:dt:(N-1)*dt; %ʱ������
sourceType = type;
switch sourceType
    case 0 
        y = A*sin(2*pi*F*t);
    case 1
        y = A*square(2*pi*F*t,50);
    otherwise
end
end

