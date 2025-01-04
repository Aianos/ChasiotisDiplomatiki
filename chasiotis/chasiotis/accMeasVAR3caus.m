%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This  script  calculates  accuracy measures of VAR systems order 3 %
% for varius lengths and sizes (N) of timeseries models of causality %
% indeces of CGCI and RCGCI and saves them in .xlsx files            %                                        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SavedMatrixPerf01=zeros(4,4);
SavedMatrixPerf02=zeros(4,4);
SavedMatrixPerf03=zeros(4,4);
SavedMatrixPerf04=zeros(4,4);
SavedMatrixPerf05=zeros(4,4);
SavedMatrixPerf11=zeros(4,4);
SavedMatrixPerf12=zeros(4,4);
SavedMatrixPerf13=zeros(4,4);
SavedMatrixPerf14=zeros(4,4);
SavedMatrixPerf15=zeros(4,4);

k=1;
for N = [15 30 60  120]
    l=1;
    for Length = [200 400 800 1600]  

        alpha=0.05;
        nMC = 10;
        m = 3;


        Sum0 = zeros(1,5);
        Sum1 = zeros(1,5);


        for i=1:nMC

            %[xM,A] = VAR_Struct.VAR3SFNGStructure(Length,N,a0);
            %[xM,A] = VAR_Struct.VAR3RingStructure(Length,N,a0);
            [xM,A] = VAR_Struct.VARpRandom(Length,N,m);

            %the original test 
            [CGCIM0,pCGCIM0] = Caus_Func.CGCinall(xM,m,1);

            %the other way for comparison
            [CGCIM1,pCGCIM1] = Caus_Func.mBTSCGCImatrix(xM,m,1); 


            A = A ~= 0;

            A = double(A);

            B1 = A(:,1:N);
            B2 = A(:,N+1:N+N);
            B3 = A(:,N+N+1:end);
            B = B1|B2|B3;

            I = diag(ones(N,1));
            adjM0 = Calc_Func.adjFDRmatrix(pCGCIM0,alpha);
            adjM0 = transpose(adjM0);
            adjM0 = adjM0 + I;

            adjM1 = Calc_Func.adjFDRmatrix(pCGCIM1,alpha);
            adjM1 = transpose(adjM1);
            adjM1 = adjM1 + I;

            trueVal = B(:);

            estimVal0 = adjM0(:);

            estimVal1 = adjM1(:);


            [perfomancestatsV0] = Calc_Func.AccuracyMeasuresAdjacency(trueVal,estimVal0);

            [perfomancestatsV1] = Calc_Func.AccuracyMeasuresAdjacency(trueVal,estimVal1);

            Sum0 = Sum0 + perfomancestatsV0;
            Sum1 = Sum1 + perfomancestatsV1;

        end

        perf0 = Sum0/nMC;
        perf1 = Sum1/nMC;


        SavedMatrixPerf01(k,l) = perf0(2);     
        SavedMatrixPerf02(k,l) = perf0(3);
        SavedMatrixPerf03(k,l) = perf0(4);
        SavedMatrixPerf04(k,l) = perf0(1);
        SavedMatrixPerf05(k,l) = perf0(5);

        SavedMatrixPerf11(k,l) = perf1(2);
        SavedMatrixPerf12(k,l) = perf1(3);
        SavedMatrixPerf13(k,l) = perf1(4);
        SavedMatrixPerf14(k,l) = perf1(1);
        SavedMatrixPerf15(k,l) = perf1(5);

        l=l+1;
    end
    k=k+1;
end

csvwrite('myDataSEN_CGC.csv', SavedMatrixPerf01);
csvwrite('myDataSPEC_CGC.csv', SavedMatrixPerf02);
csvwrite('myDataFM_CGC.csv', SavedMatrixPerf03);
csvwrite('myDataMCCS_CGC.csv', SavedMatrixPerf04);
csvwrite('myDataHD_CGC.csv', SavedMatrixPerf05);


csvwrite('myDataSEN_mBTS.csv', SavedMatrixPerf11);
csvwrite('myDataSPEC_mBTS.csv', SavedMatrixPerf12);
csvwrite('myDataFM_mBTS.csv', SavedMatrixPerf13);
csvwrite('myDataMCCS_mBTS.csv', SavedMatrixPerf14);
csvwrite('myDataHD_mBTS.csv', SavedMatrixPerf15);


