function [ disMat ] = disCopute( realKey )
%DISCOPUTE Summary of this function goes here
%   Detailed explanation goes here

n = length(realKey);
disMat = zeros(n,n);
for i=1:1:n-1
    for j=i+1:1:n
        disMat(i,j) = (((realKey(i,j)-realKey(i,i)) - (realKey(j,j)-realKey(j,i)))/2/44100)*340;
    end
end

end

