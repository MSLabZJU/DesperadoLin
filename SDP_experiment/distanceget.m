clear;clc
str='E:\Experiment_data\511_SDP_2016.8.8\';
sigRefer = wavread([str,'k3k8LFM.wav']);
% nodeCor0 = [5.703,1.059;
%            3.303,1.059;
%            0.903,1.059;
%            5.703,3.459;
%            3.303,3.459;
%            0.903,3.459;
%            5.703,5.859;
%            3.303,5.859;
%            0.903,5.859];%1-9号节点绝对坐标
nodeCor = [4.8 0;
           2.4 0;
           0 0;
           4.8 2.4;
           2.4 2.4;
           0 2.4;
           4.8 4.8;
           2.4 4.8;
           0 4.8];%1-9号节点相对坐标
realDisMat = realDis(nodeCor);
realDisMat = realDisMat + realDisMat';
anchorNo = [6 3 2 7];%选作锚节点的节点号码
varNo = [1 5 4 9 8];%选作未知节点的节点号码
for i=1:1:length(anchorNo)
    if i==1
        anchorCor = nodeCor(anchorNo(i),:);
    else
        anchorCor = [anchorCor;nodeCor(anchorNo(i),:)];
    end
end
for i=1:1:length(varNo)
    if i==1
        varCor = nodeCor(varNo(i),:);
    else
    varCor = [varCor;nodeCor(varNo(i),:)];
    end
end

coFlag = 1;
time = 0;
for num=1:1:111
    if ismember(num,[7 15 32 42 48 56 69 72 73 86 106])
        continue
    end
    time = time + 1;
   %%
   %BeepBeep测距得到任意两个节点的距离
    node1=wavread([str,'node1','\data_',num2str(num),'.wav']);
    [realKey1,value1] = findRealKey(node1,sigRefer);
    realKey(1,:) = realKey1;
    
    node2=wavread([str,'node2','\data_',num2str(num),'.wav']);
    [realKey2,value2] = findRealKey(node2,sigRefer);
    realKey(2,:) = realKey2;
    
    node3=wavread([str,'node3','\data_',num2str(num),'.wav']);
    [realKey3,value3] = findRealKey(node3,sigRefer);
    realKey(3,:) = realKey3;
    
    node4=wavread([str,'node4','\data_',num2str(num),'.wav']);
    [realKey4,value4] = findRealKey(node4,sigRefer);
    realKey(4,:) = realKey4;
    
    node5=wavread([str,'node5','\data_',num2str(num),'.wav']);
    [realKey5,value5] = findRealKey(node5,sigRefer);
    realKey(5,:) = realKey5;
    
    node6=wavread([str,'node6','\data_',num2str(num),'.wav']);
    [realKey6,value6] = findRealKey(node6,sigRefer);
    realKey(6,:) = realKey6;
    
    node7=wavread([str,'node7','\data_',num2str(num),'.wav']);
    [realKey7,value7] = findRealKey(node7,sigRefer);
    realKey(7,:) = realKey7;
    
    node8=wavread([str,'node8','\data_',num2str(num),'.wav']);
    [realKey8,value8] = findRealKey(node8,sigRefer);
    realKey(8,:) = realKey8;
    
    node9=wavread([str,'node9','\data_',num2str(num),'.wav']);
    [realKey9,value9] = findRealKey(node9,sigRefer);
    realKey(9,:) = realKey9;
    
    disMat = disCompute(realKey);
    disMat = disMat + disMat';
    %%
    %计算每一次实验的测距误差
    erFlag = 1;
    for p=1:1:8
        for q=p+1:1:9
            errorD(erFlag) = abs(disMat(p,q)-realDisMat(p,q)); 
            erFlag = erFlag + 1;
        end
    end
    erDis(time) = mean(errorD);
    %%
    %SDP自定位
    flag1 = 1;
    for i=1:1:length(anchorNo)
        for j=1:1:length(varNo)
            anchorDis(:,flag1) = [i,j,(disMat(anchorNo(i),varNo(j)))^2]';
            flag1 = flag1 + 1;
        end
    end
    
    flag2 = 1;
    for i=1:1:length(varNo)-1
        for j=i+1:1:length(varNo)
            varDis(:,flag2) = [i,j,(disMat(varNo(i),varNo(j)))^2]';
            flag2 = flag2 + 1;
        end
    end
    
    [target result] = SDP_self_callibration_relaxtion2(4,5,anchorCor,varDis,anchorDis)
    if isnan(target)==0
        xCor(coFlag,:) = result(3:7,1)';
        yCor(coFlag,:) = result(3:7,2)';
        %计算每一次的定位误差
        errorL = 0;
        for m=1:1:5
            errorL = errorL + sqrt((xCor(coFlag,m)-varCor(m,1))^2 + (yCor(coFlag,m)-varCor(m,2))^2);
        end
        erLoc(coFlag) = errorL/5;
        coFlag = coFlag + 1;
    end   
end
%%
%取平均值画图
xCorMean = mean(xCor)+[0.903 0.903 0.903 0.903 0.903];
yCorMean = mean(yCor)+[1.059 1.059 1.059 1.059 1.059];
figure;
l1 = scatter(anchorCor(:,1)+[0.903 0.903 0.903 0.903]',anchorCor(:,2)+[1.059 1.059 1.059 1.059]','k');
hold on;
l2 = scatter(varCor(:,1)+[0.903 0.903 0.903 0.903 0.903]',varCor(:,2)+[1.059 1.059 1.059 1.059 1.059]','r*');
hold on;
l3 = scatter(xCorMean,yCorMean,'gs');
hold on;
for i=1:1:5
    line([varCor(i,1)+0.903,xCorMean(i)],[varCor(i,2)+1.059,yCorMean(i)]);
end
grid;
legend('信标节点','真实坐标','估计坐标','估计误差');

