function [xM,A] = VAR1RingStructure(n,K)
% [xM,A] = VAR1RingStructure(n,K)
% VAR1RingStructure generates time series from a vector autoregressive
% system of order one, VAR(1), of length 'n' with a sparse matrix of open
% ring coupling structure. 
% INPUTS
% - n       : the time series length
% - K       : the number of variables
% OUTPUTS
% - xM      : the n x K matrix of the generated time series
% - A       : the coefficient matrix of the selected VAR(P) system.

A = zeros(K);
A(K+1:K+1:end-K) = 1;
A(K+3:K+1:end) = 1;
A = A'*0.9;
unstable=1;
while unstable==1
    lambda = eig(A);
    if any(abs(lambda)>1)
        unstable = 1;
        A = A*0.95;
    else
        unstable = 0;
    end
end

ntrans = 100; % transient period
wM = randn(K,n+ntrans);
xM = NaN*ones(K,n+ntrans);
P=1;
a0 = zeros(K,1);
xM(:,1:P) = wM(:,1:P);
for t=P+1:n+ntrans
    tmpV = a0;
    for i=1:P
        tmpV = tmpV + A(:,(i-1)*K+1:i*K)*xM(:,t-i);
    end   
    xM(:,t)=tmpV+wM(:,t);
end
xM = xM(:,ntrans+1:n+ntrans)';

