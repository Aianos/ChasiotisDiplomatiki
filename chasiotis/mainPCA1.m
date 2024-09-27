SavedMatrixPerf01=zeros(4,4,4);
SavedMatrixPerf02=zeros(4,4,4);
SavedMatrixPerf03=zeros(4,4,4);
SavedMatrixPerf04=zeros(4,4,4);
SavedMatrixPerf05=zeros(4,4,4);

    k=1;
for N = [15 30 60  120]
    l=1;
%for Length = [50 100]
for Length = [200 400 800 1600]  
   o=1;
for percMin = [0.92 0.94 0.96 0.98]


alpha=0.05;
nMC = 10;
m = 1;

Sum2 = zeros(1,5);

for i=1:nMC

%[xM,A] = VAR1RingStructure(Length,N);
%[xM,A] = VAR1SFNG(Length,N);
%[xM,A] = VAR1randomNG(Length,N); %wrong
[xM,A] = VARpRandom(Length,N,m);


%Granger Causality index 
[CGCIM2,pCGCIM2] = pcaCGCinall(xM,m,percMin,1);

A = A ~= 0;

A = double(A);

I = diag(ones(N,1));
adjM2 = adjFDRmatrix(pCGCIM2,alpha);
adjM2 = transpose(adjM2);
adjM2 = adjM2 + I;
 
trueVal = A(:);

estimVal2 = adjM2(:);

%[perfomancestatsV2] = classifystats(trueVal,estimVal2);
[perfomancestatsV2] = AccuracyMeasuresAdjacency(trueVal,estimVal2);

Sum2 = Sum2 + perfomancestatsV2;
end

perf2 = Sum2/nMC;



SavedMatrixPerf01(k,l,o) = perf2(2);    
SavedMatrixPerf02(k,l,o) = perf2(3);
SavedMatrixPerf03(k,l,o) = perf2(4);
SavedMatrixPerf04(k,l,o) = perf2(1);
SavedMatrixPerf05(k,l,o) = perf2(5);

o=o+1;
end
l=l+1;
end
k=k+1;
end

csvwrite('myDataSEN_pcaCGC.csv', SavedMatrixPerf01);
csvwrite('myDataSPEC_pcaCGC.csv', SavedMatrixPerf02);
csvwrite('myDataFM_pcaCGC.csv', SavedMatrixPerf03);
csvwrite('myDataMCCS_pcaCGC.csv', SavedMatrixPerf04);
csvwrite('myDataHD_pcaCGC.csv', SavedMatrixPerf05);

