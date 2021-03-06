%%%测试数据
% 其中一组，用来测试定位函数写的对不对
%% 节点位置
NLocs = [2.368,0,1.76;...
         3.69,3.72,0.672;...
         2.4,9.08,1.76;...
         0.05,3.72,0.678;...
         1.954,4.273,2.67]';
     
%% 可行区域 Area =[xmin xmax ymin ymax zmin zmax]     
Area = [0 4 0 10 0 3];

%% 目标位置（真实）
TgtPos = [2.100000000000000;2.190000000000000;0.386000000000000];

%% 真实距离，无噪声
realDist = [2.599192182198154,2.225038426634471,7.032067690231658,2.574619195143236,3.094650384130653];

%% 量测数据，带噪声
% msrDist = [2.644564890317673,2.773321009292493,7.094911575610854,2.607798329520521,3.132270883424523];

%% 位置估计结果
Pos = Dist3DMLGrid(NLocs,realDist,Area);% 用真实距离
% Pos = Dist3DMLGrid(NLocs,msrDist,Area);% 用带噪声的距离测量

%%% 对比 POS和TgtPos，就可以知道MLGrid写的对不对