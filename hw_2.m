clear;
n=5;
A=rand(n);
b=rand(n,1);

%理论值？
x=A\b;
%选主元高斯消去
Ab1=[A b];
for i=1:n-1
    [~,loci]=max(Ab1(i:n,i));%寻找第i列中从第i行向下的最大值位置
    loci=loci+i-1;
    Ab1([i loci],:)=Ab1([loci i],:);%交换第i行和最大值行
    for j=i+1:n
        Ab1(j,:)=Ab1(j,:)-Ab1(i,:).*Ab1(j,i)/Ab1(i,i);
    end
end
A1=Ab1(:,1:n);
b1=Ab1(:,n+1);
x1=zeros(n,1);
for i=n:-1:1
    x1(i)=(b1(i)-x1'*A1(i,:)')/A1(i,i);
end

%不选主元高斯消去
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