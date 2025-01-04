Created on 21/12/2024 by Athanasios Aianos Chasiotis

The files in this directory are for various measures of Granger causality: 
1. Granger causality index (GCI).
2. conditional Granger causality index (CGCI).
3. The folder contains the Matlab codes to run restricted conditional Granger causality index (RCGCI) based on the dynamic regression model derived by the modified backward-in-time selection (mBTS) algorithm. 
4. Files that measure granger causality with the pca method (pcaCGCI).

For each measures there are two Matlab files that can be called, a) one for the causality of a specific pair of variables in both directions, Xi -> Xj and Xj -> Xi, and b) another for the causality of all pairs of variables of the multivariate time series of K variables. The TE and PTE call mex-files compiled for Windows and linux (no Mac executables) for the nearest neighbor search. The user may want to replace the routines for nearest neighbor search in the Matlab files with the Matlab (home-made) routines. We found that in general Matlab routines are slower than the ones implemented here. The routines for k-d-tree are from a distribution of the so-called annquery (found once in the internet, but could not trace it anymore).  

List of files in the directory:
- GCin.m : the function that computes the GC index.
- GCinAll.m : the function that computes an KxK matrix of GC indexes of all the time series in an multivariete time series.
- CGCin.m : the function that computes the GC index.
- CGCinAll.m : the function that computes an KxK matrix of GC indexes of all the time series in an multivariete time series.
- mBTSCGCImatrix.m : the main function called in the script, giving out the matrix (size K x K) of RCGCI as well as the matrix of the corresponding p-values from the parametric significance test.
- mBTSCGCI.m : the function called by 'mBTSCGCImatrix' that computes the RCGCI an the corresponding p-values for a given response variable (and the K-1 driving variables).
- mBTS.m : the function called in 'mBTSCGCI' to run mBTS for the given response variable.
- DRfitmse.m : the function called in 'mBTS' and also in 'mBTSCGCI' to fit the given dynamic regression model and give out the mean square error (MSE).
- multilagmatrix.m : called in 'DRfitmse' to build the matrix of explanatory variables.
- PCAforGranger.m : the function that reduces the size of a given multivariete time series with the PCA method
- pcaCGCin.m : the function that computes the CGC index whith the help of PCA method.
- pcaCGCinall : the function that computes an KxK matrix of CGC indexes of all the time series in an multivariete time series with the help PCA method.

   

Please remember to cite when appropriate:
%=========================================================================
% Reference : E. Siggiridou, Ch. Koutlis, A. Tsimpiris, D. Kugiumtzis, 
% "Evaluation of Granger Causality Measures for Constructing Networks from 
% Multivariate Time Series", Entropy, Vol 21 (11): 1080, 2019
% Link      : http://users.auth.gr/dkugiu/
%=========================================================================

