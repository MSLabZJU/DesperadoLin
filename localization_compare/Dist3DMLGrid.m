function [ tPos ] = Dist3DMLGrid( XNode,dist,area)
% function [ tPos ] = Dist3DML( XNode,dist )
%%% 三维最大似然定位估计，搜索方式用网格搜索，方差采用所有量测一致性
%%% input:
% XNode: 信标节点位置，3*nS。每一列代表一个节点的3D坐标,每一列为[x;y;z]
% dist: 节点到目标位置，1*nS
% area: 为目标可行区域
%   nS为节点个数
%%% output
% tPos: LS定位结果3*1，[x;y;z]
%%% 
% Coded by H.D.J
% Last Modified 2016.03.21
%%%

%% 初始化
tPos = [];
%% 异常检测
dim1 = size(dist);
dim2 = size(XNode);
if( dim1(1) ~= 1 || dim2(1) ~= 3 || dim1(2) ~= dim2(2) || dim1(2) < 4)
    % 输入维度不对，或节点过少时，或初值设置为零，返回空集
    tPos = [];
    return;
end
nS = dim1(2);
%% 最大似然 Newton_Raphson
epsilon = 0.01;
mN = 50;%最大迭代次数
mCount = 0;
xmin = area(1);
xmax = area(2);
ymin = area(3);
ymax = area(4);
zmin = area(5);
zmax = area(6);
stepDi = 10;
while(1) %开始迭代
    mCount = mCount+1;
    deltaX = (xmax-xmin)/stepDi;
    deltaY = (ymax-ymin)/stepDi;
    deltaZ = (zmax-zmin)/stepDi;
    X = xmin+deltaX/2:deltaX:xmax-deltaX/2;
    Y = ymin+deltaY/2:deltaY:ymax-deltaY/2;
    Z = zmin+deltaZ/2:deltaZ:zmax-deltaZ/2;
    Sxyz=[X;Y;Z];%各个网格的位置[x;y;z]
    lnPVec = [];% 用于记录各个似然函数值，以及坐标值，4*N,每一列为[p;x;y;z]
    
    %计算每一个网格的似然值
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
    ind = find(lnP == minLnP);%查询到似然函数最小的索引
    
    if size(ind,2) ~=1 %如果有一个以上的网格的似然最小相同的情况
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
    deltaD = [deltaX;deltaY;deltaZ];%计算每一个网格的大小
    if(norm(deltaD) < epsilon || mCount >mN)
        tPos = tmpPos;
        break;
    end
end
end