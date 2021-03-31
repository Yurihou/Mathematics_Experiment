clear;
%% 参数

n=5;%矩阵的阶数
%% 代码

A=rand(n);% 构建一个n阶的随机矩阵
b=rand(n,1);% 构成一个随机的列向量，接下来解方程A*x=b

% 理论精确值？
% 经过了前面的严重病态矩阵的摩擦，我现在对计算机解方程产生了心理阴影。
x=A\b;

% 选主元高斯消去
Ab1=[A b];% 增广矩阵
for i=1:n-1
    [~,loci]=max(Ab1(i:n,i));% 寻找第i列中从第i行向下的最大值位置
    loci=loci+i-1;
    Ab1([i loci],:)=Ab1([loci i],:);% 交换第i行和最大值行
    for j=i+1:n
        Ab1(j,:)=Ab1(j,:)-Ab1(i,:).*Ab1(j,i)/Ab1(i,i);
        % 线性代数复习：用第i行消去第j行，即将第i行除以Ab(i,i)乘以Ab(j,i)
        % 即可消掉第j行的第i个元素。
    end
end
% 经过一番化简，成功将矩阵消成上三角阵。为了求解x，可以从下往上求。
% 最后一行x_n即是用b_n/a_nn即可。现在有了x_n，即可代入上一行，
% 消掉x_n，求得x_(n-1)。
A1=Ab1(:,1:n);
b1=Ab1(:,n+1);
x1=zeros(n,1);
for i=n:-1:1
    x1(i)=(b1(i)-x1'*A1(i,:)')/A1(i,i);
end

% 不选主元高斯消去
Ab2=[A b];
for i=1:n-1
%     [~,loci]=max(Ab2(i:n,i));%寻找第i列中从第i行向下的最大值位置
%     loci=loci+i-1;
%     Ab2([i loci],:)=Ab2([loci i],:);%交换第i行和最大值行
    for j=i+1:n
        Ab2(j,:)=Ab2(j,:)-Ab2(i,:).*Ab2(j,i)/Ab2(i,i);
    end
end
A2=Ab2(:,1:n);
b2=Ab2(:,n+1);
x2=zeros(n,1);
for i=n:-1:1
    x2(i)=(b2(i)-x2'*A2(i,:)')/A2(i,i);
end

err_x1=x-x1;
err_x2=x-x2;
err_k=err_x2./err_x1;
