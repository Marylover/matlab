% hdb3_coddecod.m
% Liu longwei in 2016.9.28, sunllw@163.com
clc
clear all
close all
                                               % AMI��ı���
xn=[1 0 1 1 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 0];% ���뵥������
yn=xn;% ���yn��ʼ��
num=0;% ��������ʼ��
for k=1:length(xn)
   if xn(k)==1
      num=num+1;                % "1"������
         if num/2 == fix(num/2) % ������1ʱ���-1,���м��Խ���
              yn(k)=1;
         else
              yn(k)=-1;
         end
    end
end
        % HDB3����
num=0;  % �����������ʼ��
yh=yn;  % �����ʼ��
sign=0; % ���Ա�־��ʼ��Ϊ0
V=zeros(1,length(yn));% V����λ�ü�¼���� 
B=zeros(1,length(yn));% B����λ�ü�¼����
for k=1:length(yn)
   if yn(k)==0
       num=num+1;  % ����0����������
       if num==4   % ���4����0��
         num=0;    % ����������
         yh(k)=1*yh(k-4); 
                            % ��0000�����һ��0�ı�Ϊ��ǰһ�����������ͬ���Եķ���
         V(k)=yh(k);        % V����λ�ü�¼
         if yh(k)==sign     % �����ǰV������ǰһ��V���ŵļ�����ͬ
            yh(k)=-1*yh(k); % ���õ�ǰV���ż��Է�ת,������V���ż��໥���Է�תҪ��
            yh(k-3)=yh(k);  % ���B����,��V����ͬ����
            B(k-3)=yh(k);   % B����λ�ü�¼
            V(k)=yh(k);     % V����λ�ü�¼
            yh(k+1:length(yn))=-1*yh(k+1:length(yn));
                            % ���ú���ķ�����Ŵ�V���ſ�ʼ�ٽ���仯
         end
       sign=yh(k);          % ��¼ǰһ��V���ŵļ���
     end
  else
      num=0;                % ��ǰ����Ϊ��1��������0������������
  end
end                         % �������
re=[xn',yn',yh',V',B'];     % ������: xn AMI HDB3 V&B����
                            % HDB3����
input=yh;                   % HDB3������
decode=input;               % �����ʼ��
sign=0;                     % ���Ա�־��ʼ��
for k=1:length(yh)
    if input(k) ~= 0
       if sign==yh(k)       % �����ǰ����ǰһ��������ļ�����ͬ
          decode(k-3:k)=[0 0 0 0];% �������ΪV�벢��*00V����
       end
       sign=input(k);       % ���Ա�־
    end
end
decode=abs(decode);         % ����
error=sum([xn'-decode']);   % �������ȷ�Լ���,��ͼ
subplot(3,1,1);stairs([0:length(xn)-1],xn);axis([0 length(xn) -2 2]);
subplot(3,1,2);stairs([0:length(xn)-1],yh);axis([0 length(xn) -2 2]);
subplot(3,1,3);stairs([0:length(xn)-1],decode);axis([0 length(xn) -2 2]);