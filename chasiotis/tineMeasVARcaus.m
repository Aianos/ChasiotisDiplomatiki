%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This  script  calculates  execution time of pcaCGCI method for varius %
% VAR models and saves them in .xlsx files.                             %                                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SavedMatrixTime0=zeros(4,4);
SavedMatrixTime1=zeros(4,4);


k=1;
for N = [15 30 60  120]
    l=1;
    for Length = [200 400 800 1600]  


        nMC = 10;
        m = 2;

        for i=1:nMC
            %A = VAR_Struct.VAR1RingStructure(Length,N);  
            %A = VAR_Struct.VAR1SFNG(Length,N);
            A = VAR_Struct.VAR2SFNGStructure(Length,N);
            %A = VAR_Struct.VAR2RingStructure(Length,N);
            %A = VAR_Struct.VAR3SFNGStructure(Length,N);
            %A = VAR_Struct.VAR3RingStructure(Length,N);
            %A = VAR_Struct.VARpRandom(Length,N,m);

            tic;
            [CGCIM,pCGCIM] = Caus_Func.CGCinall(A,m,1);
            T1(i) = toc;

            [RCGCIM,pRCGCIM] = Caus_Func.mBTSCGCImatrix(A,m,1);
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

