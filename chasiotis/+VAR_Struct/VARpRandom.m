function[xM,A]= VARpRandom(n,K,P)
% [xM,A] = VARpRandom(n,K,P)
% VARpRandom(n,K,P) generates time series from a vector autoregressive
% system of order P, VAR(P), of length 'n' with a sparse matrix of open
% random network structure. 
% INPUTS
% - n       : the time series length
% - K       : the number of variables
% - P       : the order
% OUTPUTS
% - xM      : the n x K matrix of the generated time series
% - A       : the coefficient matrix of the selected VAR(P) system.
alpha = 0.05; % significance level
denseperc = 8; % density of coupling network in percentage

Kcol = K*(K-1)/2;
a1V = 100*rand(K*(K-1),1);
a1V = a1V < denseperc;
a1M = NaN(K,K);
for iK=1:K
    a1M([1:iK-1 iK+1:K],iK) = a1V((iK-1)*(K-1)+1:iK*(K-1));
    a1M(iK,iK) = 1;
end
aM = a1M;
for iP=2:P
    aiM = (unidrnd(2,K,K)-1).*a1M;
    aM = [aM aiM];
end
[xM,A] = VAR_Struct.VARPstable(n,aM);