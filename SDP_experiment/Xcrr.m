function [c,k] = Xcrr(x,y)
% Compute auto- or cross-correlation for vector inputs
% clc
% x=data1;
% y=data;
    x = x(:);
    M= size(x,1);
	L = length(y);
	% Cache the length(x)
	Mcached = M;
	% Recompute length(x) in case length(y) > length(x)
	M = max(Mcached,L);
    if (L ~= Mcached) && any([L./Mcached, Mcached./L] > 30),
        % Vector sizes differ by a factor greater than 10,
		% fftfilt is faster
		neg_c = conj(fftfilt(conj(x),flipud(y))); % negative lags
		pos_c = flipud(fftfilt(conj(y),flipud(x))); % positive lags
		% Make them of almost equal length (remove zero-th lag from neg)
		lneg = length(neg_c); lpos = length(pos_c);
		neg_c = [zeros(lpos-lneg,1);neg_c(1:end-1)];
		pos_c = [pos_c;zeros(lneg-lpos,1)];
		c = [pos_c;neg_c];
	else
		if L ~= Mcached,
			% Force equal lengths
			if L > Mcached
				x = [x;zeros(L-Mcached,1)];	
			else
				y = [y;zeros(Mcached-L,1)];
			end								
        end
		% Transform both vectors
		X = fft(x,2^nextpow2(2*M-1));
		Y = fft(y,2^nextpow2(2*M-1));
        %加权过程
        %PXY=X.*conj(Y)./(abs(X).*abs(Y));                                  %PHAT
        PXY=X.*conj(Y);                                                     %BASE
        %PXY=X.*conj(Y)./(abs(X).*abs(X));                                  %ROTH
        %PXY=X.*conj(Y)./sqrt((abs(X).*abs(X)).*(abs(Y).*abs(Y)));          %SCOT
		% Compute cross-correlation
		c = ifft(PXY);
    end
    c=c(1:M);
    k = linspace(1,length(c),length(c))';
 end