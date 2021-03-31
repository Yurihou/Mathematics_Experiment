clear;
%% 方程组系数 @A*x=b
% A=[1 -9 -10;-9 1 5;8 7 1];
% b=[1;0;4];
% A=[5 -1 -3;-1 2 4;-3 4 15];
% b=[-1;0;4];
A=[10 4 5;4 10 7;5 7 10];
b=[-1;0;4];
% A=[9 -1 -1;-1 10 -1;-1 -1 15];
% b=[7;8;13];

%% 精确解，不解释。
x=A\b;

%% 参数
n=100;% 迭代次数
x_0=[1;1;1];% 初值，也用作迭代前的值

%% 雅可比迭代法
%disp('雅可比迭代法');
x_1=[0;0;0];% 迭代后的值
x_err_jakob=zeros(3,n);%误差

U=-triu(A,1);
L=-tril(A,-1);
D=diag(diag(A));
f_j=D\b;
B_j=D\(L+U);
for i=1:n
    
    x_1=B_j*x_0+f_j;
    x_0=x_1;
    x_err_jakob(:,i)=abs(x-x_1);
end

plot(1:n,x_err_jakob(:,:));
%% 高斯-赛德尔迭代法
%disp('高斯-赛德尔迭代法');
x_1=[0;0;0];% 迭代后的值
x_err_gauss=zeros(3,n);%误差

U=-triu(A,1);
L=-tril(A,-1);
D=diag(diag(A));
f_gs=(D-L)\b;
B_gs=(D-L)\U;
diag_zeros=-(ones(length(b))-eye(length(b)));
for i=1:n
    x_1=B_gs*x_0+f_gs;
    x_0=x_1;
    x_err_gauss(:,i)=abs(x-x_1);
end

hold on;
plot(1:n,x_err_gauss(:,:));
legend('jakob@x(1)','jakob@x(2)','jakob@x(3)','gauss@x(1)','gauss@x(2)','gauss@x(3)');
%% 

%disp(x);
