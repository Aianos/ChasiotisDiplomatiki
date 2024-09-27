function [CGCIxy,CGCIyx,pCGCIxy,pCGCIyx]=pcaCGCin(xV,yV,zM,m,percMin,maketest)
% [CGCIxy,CGCIyx,pCGCIxy,pCGCIyx]=pcaCGCin(xV,yV,zM,m,percMin,maketest) 
% pcaCGCin computes the conditional Granger Causality index (GCI) with the  
% modified PCA method for two time series X and Y in the presence of other 
% time series given as Z, for both directions (X->Y|Z and Y->X|Z).Where Z
% is reduced in size with the PCA method.
%
% INPUTS
% - xV          : time series 1
% - yV          : time series 2
% - zM          : the other time series accounting for 
% - m           : Order of the restricted and unrestricted AR model 
% - percMin     : Min percentage of Z information in new Z after PCA
% - maketest    : If 1 make parametric test and give out the p-values
% OUTPUTS
% - CGCIxy      : Granger Causality index from X to Y in the presence of Z
% - CGCIyx      : Granger Causality index from Y to X in the presence of Z
% - pCGCIxy     : The p-value of the parametric significance test for the
%                 CGCIxy (using the F-statistic, see Econometric 
%                 Analysis, Greene, 7th Edition, Sec 5.5.2)
% - pCGCIyx     : Same as pCGCIxy but for the opposite direction

if nargin==5
    maketest = 0;
end

N = length(xV);
if length(yV)~=N || size(zM,1)~=N
    error('All the time series should have the same length.');
end

if percMin < 0 || percMin > 1
    error('wrong percMin');
end

xV = zscore(xV);
yV = zscore(yV);
zM = zscore(zM);

z_new = PCAforGranger(zM,percMin);

if maketest
    [CGCIxy,CGCIyx,pCGCIxy,pCGCIyx] = CGCin(xV,yV,z_new,m,1);
else
    [CGCIxy,CGCIyx,pCGCIxy,pCGCIyx] = CGCin(xV,yV,z_new,m);   
end

 