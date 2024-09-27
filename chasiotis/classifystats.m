 function [perfomancestatsV] = classifystats(actualV,estimatedV)
% The fucntion 'classifystats' computed performance indices for a
% classification task, given as inputs the actual and estimated classes for
% each case. The performance indices are (at the order they are given in
% the output vector 'performancestatsV':
% accuracy, sensitivity, specificity, precision, recall, F-measure, G-mean.
% Note that the class labels are numeric and the class label denoted as '1'
% is considered as the 'positive' and all other class labels are considered
% to be included in the 'negative' class.
% INPUT: 
% - actualV     : vector of size N x 1, where N is the number of cases, 
%                 containing the actual class labels 
% - estimatedV  : vector of size N x 1, where N is the number of cases, 
%                 containing the estimated class labels 
% OUTPUT: 
% - perfomancestatsV: a vector of size 1 x 7 containing the 7 performance
%                     indices: accuracy, sensitivity, specificity, 
%                              precision, recall, F-measure, G-mean.
indexV = (actualV==1);
actualV(~indexV) = 2;
index2V = (estimatedV==1);
estimatedV(~index2V) = 2;

p = length(actualV(indexV));
n = length(actualV(~indexV));
N = p+n;

tp = sum(actualV(indexV)==estimatedV(indexV));
tn = sum(actualV(~indexV)==estimatedV(~indexV));
fp = n-tn;
fn = p-tp;

tp_rate = tp/p;
tn_rate = tn/n;

accuracy = (tp+tn)/N;
sensitivity = tp_rate;
specificity = tn_rate;
precision = tp/(tp+fp);
recall = sensitivity;
f_measure = 2*((precision*recall)/(precision + recall));
gmean = sqrt(tp_rate*tn_rate);

perfomancestatsV = [accuracy sensitivity specificity precision recall f_measure gmean];