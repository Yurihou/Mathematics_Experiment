clear;
%% 参数区
A=[-4 1 1 1;1 -4 1 1;1 1 -4 1;1 1 1 -4];
b=[1;1;1;1];
n=10;% 迭代次数
omega=1.5;% 加权因子

%% 计算区
x_0=[0;0;0;0];
x_1=[0;0;0;0];

x=A\b;% 精确解

x_err=zeros(4,n);% 误差

for i=1:n
    U=-triu(A,1);
    L=-tril(A,-1);
    D=diag(diag(A));
    f_omega=omega.*inv(D-omega*L)*b;
    B_omega=(D-omega*L)\(omega*U+(1-omega)*D);
    x_1=B_omega*x_0+f_omega;
    x_0=x_1;
    x_err(:,i)=abs(x-x_1);
end

%% 显示区
plot(1:n,x_err(:,:));
