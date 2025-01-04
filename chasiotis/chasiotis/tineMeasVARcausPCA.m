%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This  script  calculates  execution time of CGCI and RCGCI method for %
% varius VAR models and saves them in .xlsx files.                      %                                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SavedMatrixTime=zeros(4,4,4);

k=1;
for N = [15 30 60  120]
    l=1;
    for Length = [200 400 800 1600]  
        o=1;
        for percMin = [0.92 0.94 0.96 0.98]

            nMC = 10;
            m = 3;

            for i=1:nMC
                %A = VAR_Struct.VAR1RingStructure(Length,N);  
                %A = VAR_Struct.VAR1SFNG(Length,N);
                %A = VAR_Struct.VAR2SFNGStructure(Length,N);
                A = VAR_Struct.VAR2RingStructure(Length,N);
                %A = VAR_Struct.VAR3SFNGStructure(Length,N);
                %A = VAR_Struct.VAR3RingStructure(Length,N);
                %A = VAR_Struct.VARpRandom(Length,N,m);

                tic;
                [CGCIM2,pCGCIM2] = Caus_Func.pcaCGCinall(A,m,percMin,1);
                T1(i) = toc;

            end    

            avrg = sum(T1)/nMC;

            SavedMatrixTime(k,l,o) = avrg;

            o=o+1;
        end
        l=l+1;
    end
    k=k+1;
end

csvwrite('myDatatimepcaCGC.csv', SavedMatrixTime);