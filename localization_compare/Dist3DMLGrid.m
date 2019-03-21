function [ tPos ] = Dist3DMLGrid( XNode,dist,area)
% function [ tPos ] = Dist3DML( XNode,dist )
%%% ��ά�����Ȼ��λ���ƣ�������ʽ���������������������������һ����
%%% input:
% XNode: �ű�ڵ�λ�ã�3*nS��ÿһ�д���һ���ڵ��3D����,ÿһ��Ϊ[x;y;z]
% dist: �ڵ㵽Ŀ��λ�ã�1*nS
% area: ΪĿ���������
%   nSΪ�ڵ����
%%% output
% tPos: LS��λ���3*1��[x;y;z]
%%% 
% Coded by H.D.J
% Last Modified 2016.03.21
%%%

%% ��ʼ��
tPos = [];
%% �쳣���
dim1 = size(dist);
dim2 = size(XNode);
if( dim1(1) ~= 1 || dim2(1) ~= 3 || dim1(2) ~= dim2(2) || dim1(2) < 4)
    % ����ά�Ȳ��ԣ���ڵ����ʱ�����ֵ����Ϊ�㣬���ؿռ�
    tPos = [];
    return;
end
nS = dim1(2);
%% �����Ȼ Newton_Raphson
epsilon = 0.01;
mN = 50;%����������
mCount = 0;
xmin = area(1);
xmax = area(2);
ymin = area(3);
ymax = area(4);
zmin = area(5);
zmax = area(6);
stepDi = 10;
while(1) %��ʼ����
    mCount = mCount+1;
    deltaX = (xmax-xmin)/stepDi;
    deltaY = (ymax-ymin)/stepDi;
    deltaZ = (zmax-zmin)/stepDi;
    X = xmin+deltaX/2:deltaX:xmax-deltaX/2;
    Y = ymin+deltaY/2:deltaY:ymax-deltaY/2;
    Z = zmin+deltaZ/2:deltaZ:zmax-deltaZ/2;
    Sxyz=[X;Y;Z];%���������λ��[x;y;z]
    lnPVec = [];% ���ڼ�¼������Ȼ����ֵ���Լ�����ֵ��4*N,ÿһ��Ϊ[p;x;y;z]
    
    %����ÿһ���������Ȼֵ
    for k0 = 1:stepDi
        for k1 = 1:stepDi
            for k2 = 1:stepDi
                tmpLoc = [Sxyz(1,k0);Sxyz(2,k1);Sxyz(3,k2)];
                D = [];
                for iS = 1:nS
                    tmpD = norm(tmpLoc-XNode(:,iS));
                    D = [D,tmpD];
                end
                res = sum((D-dist).^2);
                tmp = [res;tmpLoc];
                lnPVec = [lnPVec,tmp];
            end
        end
    end
    lnP = lnPVec(1,:);
    minLnP = min(lnP);
    ind = find(lnP == minLnP);%��ѯ����Ȼ������С������
    
    if size(ind,2) ~=1 %�����һ�����ϵ��������Ȼ��С��ͬ�����
        xmin = min(lnPVec(2,ind))-deltaX;
        ymin = min(lnPVec(3,ind))-deltaY;
        zmin = min(lnPVec(4,ind))-deltaZ;
        xmax = max(lnPVec(2,ind))+deltaX;
        ymax = max(lnPVec(3,ind))+deltaY;
        zmax = max(lnPVec(4,ind))+deltaZ;  
        tmpPos =[mean(lnPVec(2,ind));mean(lnPVec(3,ind));mean(lnPVec(4,ind))];
    else
        xmin = lnPVec(2,ind)-deltaX;
        ymin = lnPVec(3,ind)-deltaY;
        zmin = lnPVec(4,ind)-deltaZ;
        xmax = lnPVec(2,ind)+deltaX;
        ymax = lnPVec(3,ind)+deltaY;
        zmax = lnPVec(4,ind)+deltaZ;
        tmpPos = lnPVec(2:4,ind);
    end
    deltaD = [deltaX;deltaY;deltaZ];%����ÿһ������Ĵ�С
    if(norm(deltaD) < epsilon || mCount >mN)
        tPos = tmpPos;
        break;
    end
end
end