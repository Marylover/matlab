% adaptive_equlization.m
% Liu longwei in 2016.9.29, sunllw@163.com
clc
clear all
close all

Ts=1e-3;               % 码元时隙Ts=1ms ,相应地码速率为1000bps
r=0.5;                 % 滚降系数
t=(-10e-3):1e-4:10e-3; % 时间从-10ms 到+10ms 共20 个时隙
[num,den] = rcosine(1e3,1e4,'fir/sqrt',r,10); % 平方根滚降滤波器设计
data=sign(rand(1,5000)-0.5);                  % 输入5000 个随机数据,双极性.
datain=[data;zeros(9,length(data))];          % 将每个数据取样10个点
datain=reshape(datain,1,10*length(data)); % 用1点表数据,其余9点为0,表冲激
figure
plot(datain);
wavout=filter(num,den,datain); % 发送滤波
figure
plot(wavout);
n=10;fs=10000;fc=500;          % 低通信道
[B,A] = butter(n,fc/(fs/2));   % 截止频率为fc=500Hz的10阶巴特沃思低通滤波器
noise=0.00*randn(size(wavout));
wavout=wavout+noise;           % 加入噪声
wavout1=filter(B,A,wavout);    % 传输信道1(500Hz低通)
wavout2=0.2*[zeros(1,24),wavout(1:length(wavout)-24)]+...
        1*[zeros(1,34),wavout(1:length(wavout)-34)]+...
        0.4*[zeros(1,44),wavout(1:length(wavout)-44)];% 传输信道2(多径信道)
wavout=[wavout1(1:20000),wavout2(20001:length(wavout))];
% 信道在第2秒时刻切换
wavout=filter(num,den,wavout);     % 接收匹配滤波器
rec=wavout(225:10:length(wavout)); 
% 在最佳时刻每隔10点取样一次,约延迟201+24样值
recpj=sign(rec);                   % 判决最佳判决门限为0,利用符号函数即完成了判决
% 自适应滤波
X=rec; % 接收信号(已经取样)
L=1;   % 均衡器为2*L级,共2*L+1个抽头,改变B矩阵的长度即改变了均衡器的级数
B=[zeros(1,L), 1 ,zeros(1,L)]; % 均衡器初始系数
adjstep=0.01; % 调整步长
% 自适应滤波器收敛与否与输入信号, 均衡器的初始系数以及调整步长有关
M=length(B);  % 记录均衡器抽头数
N=length(X);  % 记录输入信号的长度
bb(N-M+1,1:length(B))=0; %用于记录均衡器系数变化的存储变量
for k=1:N-M+1;                     % 递推计算自适应滤波器系数
   y(k)=sum(X(k:k+M-1).*fliplr(B));% 滤波输出 
   XK=X(k:k+M-1);                  % 保存滤波器各延时器的状态
   ek=sign(y(k))-y(k);             % 判决并形成误差
   e(k)=ek;                        % 误差存入矩阵以便作图
   dlt=fliplr(XK).*ek.*adjstep;    % 形成反馈调整量
   B=B+dlt;                        % 递推得到新的滤波器系数
   bb(k,:)=B;                      % 记录每次递推所得的均衡器抽头系数
end
BB1=[bb(1900,:);zeros(9,2*L+1)];     % 系数转换（第2秒以前：低通信道）
BB1=reshape(BB1,1,10*(2*L+1));       % 采样率为10KHz的均衡滤波器系数
BBout1=filter(BB1,1,wavout) ;        % 均衡滤波器输出(用自适应滤波器收敛结果系数)
BB2=[B;zeros(9,2*L+1)];              % 系数转换（第2秒以后：多径信道）
BB2=reshape(BB2,1,10*(2*L+1));       % 采样率为10KHz的均衡滤波器系数
BBout2=filter(BB2,1,wavout) ;        % 均衡滤波器输出(用自适应滤波器收敛结果系数)
%--打印数据曲线--
figure(1);plot(e);title('误差曲线 \epsilon_k');        % 误差曲线
figure(2);plot(bb);title('自适应均衡器抽头系数c_j');   % 滤波器系数变化曲线
eyediagram(BBout1(15000:20000),20);  % 均衡输出眼图（第2秒以前：低通信道）
eyediagram(BBout2(46001:50000),20);  % 均衡输出眼图（第2秒以后：多径信道）
eyediagram(wavout(10001:19000),20);  % 均衡前的眼图（第2秒以前）
eyediagram(wavout(46001:50000),20);  % 均衡前的眼图（第2秒以后）