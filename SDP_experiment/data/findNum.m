function [ num ] = findNum( vec,element )
%FINDNUM Summary of this function goes here
%   Detailed explanation goes here

n = length(vec);
num = 0;
for i=1:1:n
    if vec(i)<=element
        num = num + 1; 
    end
end

end

