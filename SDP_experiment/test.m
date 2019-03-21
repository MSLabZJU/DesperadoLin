% varCor = [ 5.703,1.059;
%            5.703,3.459;
%            3.303,3.459;
%            5.703,5.859;
%            3.303,5.859;
%            0.903,5.859];
% anchorCor = [0.903,1.059;
%              3.303,1.059;
%              0.903,3.459;];

anchorCor = [0 2.4;0 0;2.4 0;4.8 4.8];
varCor = [4.8 0;2.4 2.4;4.8 2.4;0 4.8;2.4 4.8];



flag1=1;
for i=1:1:4
    for j=1:1:5
        D_anchor(flag1) = (anchorCor(i,1)-varCor(j,1))^2 + (anchorCor(i,2)-varCor(j,2))^2;
        flag1 = flag1+1;
    end
end

flag2=1;
for i=1:1:4
    for j=i+1:1:5
        D_var(flag2) = (varCor(i,1)-varCor(j,1))^2 + (varCor(i,2)-varCor(j,2))^2;
        flag2 = flag2+1;
    end
end

[target,result] = SDP_self_callibration_relaxtion(4,5,anchorCor,D_var,D_anchor)