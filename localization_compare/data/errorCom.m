clc;
clear;
temp = load('realLoc.mat');
realLoc = temp.realLoc;
temp = load('loc.mat');
loc = temp.loc;
temp = load('SDPandLoc.mat');
res = temp.res;
n = length(res);

for i=1:1:n
   error1(i) = sqrt((loc(i,1)-realLoc(i,1))^2 + (loc(i,2)-realLoc(i,2))^2); 
   error2(i) = sqrt((res(i,1)-realLoc(i,1))^2 + (res(i,2)-realLoc(i,2))^2); 
end

figure;
plot(error1,'r');
hold on;
plot(error2);