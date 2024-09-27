function [xM,cM] = VAR2SFNGStructure(n,K,a0)
% xM = VARPstable(n,A,a0)
% VARPstable generates time series from a vector autoregressive system of
% order P, VAR(P), of length 'n'. If the constant term 'a0' is not
% specified it is supposed to be zero. The input matrix aM has only ones
% and zeros and size K x (K*P), so that the first K x K block is the matrix
% of coefficients for lag one, the second for lag 2 etc. The coefficients
% are initially given large values, which are then decreased to finally
% obtain stable (stationary) solution. 
% INPUTS
% - n       : the time series length
% - aM      : the input matrix of VAR(P), it should be of size K x (K*P)
%             and contain zeros and ones. 
% - a0      : constant term, vector of size K x 1 (default is zero)
% OUTPUTS
% - xM      : the n x K matrix of the generated time series
% - cM      : the coefficient matrix of the selected VAR(P) system.

A1 = SFNG(K, 1, 1);
A1 = A1'*0.9;

A2 = SFNG(K, 1, 1);
A2 = A2'*0.9;

aM = [A1,A2];

if nargin==2
    K = size(aM,1);
    a0 = zeros(K,1);
end
if size(aM,2)/size(aM,1) ~= floor(size(aM,2)/size(aM,1))
    error('The input coefficient matrix must have size K x (K*P), for K variables and P order.');
end
K = size(aM,1);
P = size(aM,2)/size(aM,1);
sigmaM = eye(K);
% The coefficient matrix has initially random relatively large values,
% more positive and less negative.
cM = sign(0.5+randn(size(aM))).*(0.5+1.5*rand(size(aM))).*aM; 
% Check stability and iteratively decrease all coefficients by the same
% percentage until stability is succeeded. 
unstable=1;
while unstable==1
    cbigM = [cM; [eye(K*(P-1)) zeros(K*(P-1),K)]];    
    lambda = eig(cbigM);
    if any(abs(lambda)>1)
        unstable = 1;
        cM = cM*0.95;
    else
        unstable = 0;
    end
end
% Generate the multivariate time series from the VAR(P) process. Let a
% transient period in case of extreme initial condition.
ntrans = 100; % transient period
wM = randn(K,n+ntrans);
xM = NaN*ones(K,n+ntrans);
xM(:,1:P) = wM(:,1:P);
for t=P+1:n+ntrans
    tmpV = a0;
    for i=1:P
        tmpV = tmpV + cM(:,(i-1)*K+1:i*K)*xM(:,t-i);
    end   
    xM(:,t)=tmpV+wM(:,t);
end
xM = xM(:,ntrans+1:n+ntrans)';