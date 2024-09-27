n = 200; % time series length
K = 15; % Number of variables, network size
alpha = 0.05; % significance level
% rng(1);
denseperc = 10; % density of coupling network in percentage
P = 1; % The order of the VAR process

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

[xM,cM] = VARpRandom(n,K,P);
%[xM,cM] = VAR1RingStructure(n,K);
%[xM,cM] = VAR1SFNG(n,K);
%[xM,cM] = VAR2SFNGStructure(n,K);
%[xM,cM] = VAR2RingStructure(n,K);

figure(1)
clf
pcolor(cM(:,1:K))
colorbar
h = plotmts(xM,1,1,K,1,[],2);
% fprintf('Coefficient matrix: \n')
% cM
sigAM = a1M' ~= 0;
plotnetworktitle(sigAM,[],[],'original-network',3);

[CGCIM,pCGCIM] = CGCinall(xM,P,1);
[RCGCIM,pRCGCIM] = mBTSCGCImatrix(xM,P,1);
[CGCIM2,pCGCIM2] = pcaCGCinall(xM,P,0.96,1);

plotnetworktitle(CGCIM,[],[],'CGCI-network',4);

sigCGCIM = pCGCIM < alpha;  % The standard test
sigCGCIM = adjFDRmatrix(pCGCIM,alpha,2);  % The more conservative test
sigCGCIM = transpose(sigCGCIM);
plotnetworktitle(sigCGCIM,[],[],'sigCGCI-network',5);
XoriV = reshape(sigAM,K*K,1);
XoriV(1:K+1:K*K)=[];
XestV = reshape(sigCGCIM,K*K,1);
XestV(1:K+1:K*K)=[];
[perfomancestatsV] = AccuracyMeasuresAdjacency(XoriV,XestV);
%fprintf('Sens=%1.3f  Spec=%1.3f  MCC=%1.3f  FS=%1.3f  HD=%d \n',...
%    sensS,specS,MCCS,FS,HamDisS);

