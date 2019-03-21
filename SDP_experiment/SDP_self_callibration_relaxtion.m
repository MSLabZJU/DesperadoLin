function [target result ] = SDP_self_callibration_relaxtion( m,n,Coordinate_anchor,D_var,D_anchor )
%SDP_SELF_CALLIBRATION_RELAXTION Summary of this function goes here
%   Detailed explanation goes here

%m为锚节点的个数
%n为未知节点的个数
%Coordinate_anchor为锚节点的已知的坐标
%D_var为未知节点之间的距离
%D_anchor为未知节点到锚节点的距离
%%
% 为计算做准备
num_anchor = m;
num_var = n;
num_equal_cons_var = n*(n-1)/2;%未知节点的等式约束个数
num_equal_cons_anchor = n*m;%未知节点到锚节点的等式约束个数
Coor_anchor = Coordinate_anchor;
Dis_var = D_var;
Dis_anchor = D_anchor;

%与未知节点之间的等式约束表示有关的矩阵
M_var = zeros(num_var+2,num_equal_cons_var);
%与未知节点和锚节点之间等式约束有关的矩阵
M_anchor = zeros(num_var+2,num_equal_cons_anchor);

flag1 = 1;
for i=1:1:(num_var-1)
    for j=(i+1):1:num_var
        %第i个未知节点依次到第j个未知节点的距离
        M_var(:,flag1) = [0 0 (SDP_ei(num_var,i)-SDP_ei(num_var,j))]'; 
        flag1 = flag1+1;
    end
end

flag2 = 1;
for i=1:1:num_anchor
    for j=1:1:num_var
        %第i个锚节点依次到第j个未知节点的距离
        M_anchor(:,flag2) = [Coor_anchor(i,:) -SDP_ei(num_var,j)]'; 
        flag2 = flag2+1;
    end
end

p1 = [1 0 zeros(1,num_var)];
q1 = p1';
p2 = [0 1 zeros(1,num_var)];
q2 = p2';
p3 = [1 1 zeros(1,num_var)];
q3 = p3';
%%
%调用工具箱计算
t = sdpvar(1);
y = sdpvar(num_var+2,num_var+2);
a = [(p1*y*q1)==1,(p2*y*q2)==1,(p3*y*q3)==2];

temp_cons1 = 0;
temp_cons2 = 0;
for i=1:1:num_equal_cons_var
    temp_cons1 = temp_cons1 + (M_var(:,i)'*y*M_var(:,i) - Dis_var(i))^2;
end
for i=1:1:num_equal_cons_anchor
    temp_cons2 = temp_cons2 + (M_anchor(:,i)'*y*M_anchor(:,i) - Dis_anchor(i))^2;
end
b = [sqrt(temp_cons1+temp_cons2)<=t];

c=[y>=0];
obj = t;
constraint = [a,b,c];

% ops = sdpsettings('usex0',1);
solvesdp(constraint,obj);
result = double(y);
target = double(t);
%%
% 

end