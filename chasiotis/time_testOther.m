%Time test of the my new functions

SavedMatrixTime0=zeros(4,4);
SavedMatrixTime1=zeros(4,4);


    k=1;
for N = [15 30 60  120]
    l=1;
for Length = [200 400 800 1600]  


nMC = 10;
m = 2;

for i=1:nMC
%A = VAR1RingStructure(Length,N);    
%A = VAR1randomNG(Length,N); wrong
%A = VAR1SFNG(Length,N);
A = VAR2SFNGStructure(Length,N);
%A = VAR2RingStructure(Length,N);
%A = VAR3SFNGStructure(Length,N);
%A = VAR3RingStructure(Length,N);
%A = VARpRandom(Length,N,m);

tic;
[CGCIM,pCGCIM] = CGCinall(A,m,1);
T1(i) = toc;

[RCGCIM,pRCGCIM] = mBTSCGCImatrix(A,m,1);
T2(i) = toc - T1(i);

end    

avrg1 = sum(T1)/nMC;
avrg2 = sum(T2)/nMC;


SavedMatrixTime0(k,l) = avrg1;
SavedMatrixTime1(k,l) = avrg2;

l=l+1;
end
k=k+1;
end

csvwrite('myDatatimeCGC.csv', SavedMatrixTime0);
csvwrite('myDatatimemBTS.csv', SavedMatrixTime1);

