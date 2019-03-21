function [ out ] = SDP_ei( len,location )
%SDP_EI Summary of this function goes here
%   Detailed explanation goes here

%返回值out为行向量

temp = zeros(1,len);
temp(location) = 1;
out = temp;

end

