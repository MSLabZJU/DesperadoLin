function [ target result ] = SDP_self_callibration_relaxtion2( m,n,Coordinate_anchor,D_var,D_anchor )
%SDP_SELF_CALLIBRATION_RELAXTION Summary of this function goes here
%   Detailed explanation goes here

%mΪê�ڵ�ĸ���
%nΪδ֪�ڵ�ĸ���
%Coordinate_anchorΪê�ڵ����֪������
%D_varΪδ֪�ڵ�֮��ľ���
%D_anchorΪδ֪�ڵ㵽ê�ڵ�ľ���
%%
% Ϊ������׼��
num_anchor = m;
num_var = n;
num_equal_cons_var = length(D_var(1,:));%δ֪�ڵ�ĵ�ʽԼ������
num_equal_cons_anchor = length(D_anchor(1,:));%δ֪�ڵ㵽ê�ڵ�ĵ�ʽԼ������
Coor_anchor = Coordinate_anchor;
Dis_var = D_var;
Dis_anchor = D_anchor;

%��δ֪�ڵ�֮��ĵ�ʽԼ����ʾ�йصľ���
M_var = zeros(num_var+2,num_equal_cons_var);
%��δ֪�ڵ��ê�ڵ�֮���ʽԼ���йصľ���
M_anchor = zeros(num_var+2,num_equal_cons_anchor);

% flag1 = 1;
% for i=1:1:(num_var-1)
%     for j=(i+1):1:num_var
%         %��i��δ֪�ڵ����ε���j��δ֪�ڵ�ľ���
%         M_var(:,flag1) = [0 0 (SDP_ei(num_var,i)-SDP_ei(num_var,j))]'; 
%         flag1 = flag1+1;
%     end
% end

for i=1:1:num_equal_cons_var
    M_var(:,i) = [0 0 (SDP_ei(num_var,D_var(1,i))-SDP_ei(num_var,D_var(2,i)))];
end

% flag2 = 1;
% for i=1:1:num_anchor
%     for j=1:1:num_var
%         %��i��ê�ڵ����ε���j��δ֪�ڵ�ľ���
%         M_anchor(:,flag2) = [Coor_anchor(i,:) -SDP_ei(num_var,j)]'; 
%         flag2 = flag2+1;
%     end
% end

for i=1:1:num_equal_cons_anchor
    M_anchor(:,i) = [Coor_anchor(D_anchor(1,i),:) -SDP_ei(num_var,D_anchor(2,i))];
end

p1 = [1 0 zeros(1,num_var)];
q1 = p1';
p2 = [0 1 zeros(1,num_var)];
q2 = p2';
p3 = [1 1 zeros(1,num_var)];
q3 = p3';
%%
%���ù��������
t = sdpvar(1);
y = sdpvar(num_var+2,num_var+2);
a = [(p1*y*q1)==1,(p2*y*q2)==1,(p3*y*q3)==2];

temp_cons1 = 0;
temp_cons2 = 0;
for i=1:1:num_equal_cons_var
    temp_cons1 = temp_cons1 + (M_var(:,i)'*y*M_var(:,i) - Dis_var(3,i))^2;
end
for i=1:1:num_equal_cons_anchor
    temp_cons2 = temp_cons2 + (M_anchor(:,i)'*y*M_anchor(:,i) - Dis_anchor(3,i))^2;
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