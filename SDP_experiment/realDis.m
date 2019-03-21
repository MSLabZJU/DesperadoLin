function [ realDis ] = realDis( nodeCor )
%REALDIS Summary of this function goes here
%   Detailed explanation goes here
n = length(nodeCor);
realDis = zeros(n,n);
for i=1:1:n-1
    for j=i+1:1:n
        realDis(i,j) = sqrt((nodeCor(i,1)-nodeCor(j,1))^2 + (nodeCor(i,2)-nodeCor(j,2))^2);
    end
end

end

