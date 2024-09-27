function [perfomancestatsV] = AccuracyMeasuresAdjacency(XoriV,XestV)
% [sensS,specS,MCCS,FS,HamDisS] = AccuracyMeasuresAdjacency(XoriV,XestV)
% INPUTS
% - XoriV   : a vector p x 1 of zeros and ones of the original two classes
% - XestV   : a vector p x 1 of zeros and ones of the estimated two classes
% OUTPUTS
% - senS    : Sensitivity
% - specS   : Specificity
% - MCCS    : Mathews correlation coefficient
% - FS      : F-score
% - HamDisS : Hamming Distance

n = length(XoriV);
if length(XestV)~=n
    error('The vectors of true and estimated classes do not have the same length.');
end
noriclass1 = sum(XoriV>0);  % class1->positives, class2->negatives
noriclass2 = n - noriclass1;
diffindxV = XoriV - XestV;

FN = length(find(diffindxV==1));
FP = length(find(diffindxV==-1));
TP = noriclass1-FN;
TN = noriclass2-FP;
sensS = TP/(TP+FN);
specS = TN/(TN+FP);
pospredvalue = TP/(TP+FP);
MCCS=(TP*TN-FP*FN)/((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))^0.5;
if isnan(MCCS)
    MCCS=0;
end
FS=2*((pospredvalue*sensS)/(pospredvalue+sensS));
if isnan(FS)
    FS=0;
end
HamDisS = FN+FP;

perfomancestatsV = [MCCS,sensS,specS,FS,HamDisS];
