function [ realKey,value ] = findRealKey( node,sigRefer )
%FINDREALKEY Summary of this function goes here
%   Detailed explanation goes here

    nodeOrg=node(4410*2:end,1);
    nodeSig = dtFilter(nodeOrg);
    [value key] = Xcrr(nodeSig,sigRefer);
    [peak peakkey]=findpeaks(value,'MINPEAKDISTANCE',4410*7,'MINPEAKHEIGHT',10);
    for i=1:size(peakkey)
        realKey(i)=realPeakkey(value,peakkey(i));
    end

end

