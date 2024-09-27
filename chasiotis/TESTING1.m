Length=500;
N=50;
percMin=0.92;
alpha=0.05;
nMC = 10;
m = 1;


[xM,A] = VAR1TEST(Length,N);

%the original test 
[CGCIM0,pCGCIM0] = CGCinall(xM,m,1);
%the other way for comparison
[CGCIM1,pCGCIM1] = mBTSCGCImatrix(xM,m,1); 
%the pca way for comparison
[CGCIM2,pCGCIM2] = pcaCGCinall(xM,m,percMin,1);

A = A ~= 0;

A = double(A);

figure(1)
clf
pcolor(A(:,1:N))
colorbar
h = plotmts(xM,1,1,N,1,[],2);
% fprintf('Coefficient matrix: \n')
% cM

plotnetworktitle(A,[],[],'REAL-network',3);

I = diag(ones(N,1));

adjM0 = adjFDRmatrix(pCGCIM0,alpha);
adjM0 = transpose(adjM0);
adjM0 = adjM0 + I;
plotnetworktitle(adjM0,[],[],'CGCI-network',4);

adjM1 = adjFDRmatrix(pCGCIM1,alpha);
adjM1 = transpose(adjM1);
adjM1 = adjM1 + I;
plotnetworktitle(adjM1,[],[],'mBTS-network',5);

adjM2 = adjFDRmatrix(pCGCIM2,alpha);
adjM2 = transpose(adjM2);
adjM2 = adjM2 + I;
plotnetworktitle(adjM2,[],[],'PCACGCI-network',6);

trueVal = A(:);
estimVal0 = adjM0(:);
estimVal1 = adjM1(:);
estimVal2 = adjM2(:);

[perfomancestatsV0] = AccuracyMeasuresAdjacency(trueVal,estimVal0);
[perfomancestatsV1] = AccuracyMeasuresAdjacency(trueVal,estimVal1);
[perfomancestatsV2] = AccuracyMeasuresAdjacency(trueVal,estimVal2);
