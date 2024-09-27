function [z_new] = PCAforGranger(z,percMin)
% [z_new] = PCAforGranger(z,percMin)
% PCAforGranger computes the redused in size time series z_new form the
% time series z using the PCA method. The minimum percentage of the
% information of z in z_new is given by the percMin.
%
%
% INPUTS
% - z           : the original time series
% - percMin     : Min percentage of Z information in new Z after PCA
% OUTPUTS
% - z_new       : the reduced in size time series after PCA


CovMatrix = cov(z);
EigVal = eig(CovMatrix);
[EigVec,V] = eig(CovMatrix);
percentofinfo = EigVal./sum(EigVal);
percentofinfo = flip(percentofinfo);
sizeZ = size(z);


%Choose the components to keep (Proportion of variance accounted for criterion)
sum1 = 0;
index = 0;
for i=1:sizeZ(2)
    sum1 = sum1 + percentofinfo(i);
    if sum1 <= percMin
        index = index+1;
    end
    %sum1 = sum1 + percentofinfo(i);
end    
      

%Create the new z
FeatureVector = EigVec(:,sizeZ(2)-index+1:sizeZ(2)); 
z_new = transpose(FeatureVector)*transpose(z);
z_new = transpose(z_new);



