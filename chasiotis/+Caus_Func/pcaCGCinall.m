function [CGCIM,pCGCIM] = pcaCGCinall(xM,m,percMin,maketest)
% [CGCIM,pCGCIM] = pcaCGCinall(xM,m,percMin,maketest)
% pcaCGCinall computes the conditional Granger Causality index (GCI)with the  
% modified method of PCA for all time series pairs (Xi,Xj) in the presence 
% of the rest time series in the vector time series given in X reduced in  
% quantity with the PCA method, for both directions (Xi->Xj|(X-{Xi,Xj} and 
% Xj->Xi|(X-{Xi,Xj}).
%
% INPUTS
% - xM          : the vector time series  
% - m           : Order of the restricted and unrestricted AR model 
% - percMin     : Min percentage of Z information in new Z after PCA
% - maketest    : If 1 make parametric test and give out the p-values
% OUTPUTS
% - CGCIM       : The matrix KxK of the conditional Granger Causality
%                 indexes, (i,j) for CGCI (Xi->Xj) 
% - pCGCIM      : The p-values of the parametric significance test for the
%                 values in CGCIM (using the F-statistic, see Econometric 
%                 Analysis, Greene, 7th Edition, Sec 5.5.2)


if nargin==3
    maketest = 0;
end

if percMin < 0 || percMin > 1
    error('wrong percMin');
end

[N,K] = size(xM);
xM = zscore(xM);

CGCIM = NaN*ones(K,K);
pCGCIM = NaN*ones(K,K);
for iK=1:K
    for jK=iK+1:K
        
        zM=xM;
        xV=xM(:,iK);
        yV=xM(:,jK);
        zM(:,jK) = [];
        zM(:,iK) = [];
        
        z_new = Caus_Func.PCAforGranger(zM,percMin);
        
        if maketest 
           [CGCIM(iK,jK),CGCIM(jK,iK),pCGCIM(iK,jK),pCGCIM(jK,iK)] = Caus_Func.CGCin(xV,yV,z_new,m,1);
        else  
           [CGCIM(iK,jK),CGCIM(jK,iK),pCGCIM(iK,jK),pCGCIM(jK,iK)] = Caus_Func.CGCin(xV,yV,z_new,m);   
        end
        
    end   
end