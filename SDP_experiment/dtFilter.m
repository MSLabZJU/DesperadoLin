function [ signal ] = dtFilter( signalOrignal )
%DTFILTER Summary of this function goes here
%   Detailed explanation goes here

fs = 44100;
[n,wn,bta,ftype]=kaiserord([2800 3000 8000 8500],[0 1 0],[0.01 0.01 0.01],fs);
pulseResponse=fir1(n,wn,ftype,kaiser(n+1,bta),'noscale');
signal=filter(pulseResponse,1,signalOrignal);    %带通滤波3~8K进行以备互相关


end

