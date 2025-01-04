function [xM,A] = VAR1TEST(n,K)
% [xM,A] = VAR1randomNG(n,K)
% VAR1randomNG generates time series from a vector autoregressive
% system of order one, VAR(1), of length 'n' with a sparse matrix of open
% random network structure. 
% INPUTS
% - n       : the time series length
% - K       : the number of variables
% OUTPUTS
% - xM      : the n x K matrix of the generated time series
% - A       : the coefficient matrix of the selected VAR(P) system.
% Initialize the adjacency matrix with zeros
A = zeros(K);

 % Determine the split point for tree and partial mesh topologies
    split_point = floor(K / 2);

    % Define connections for a binary tree topology (first half nodes)
    for i = 1:split_point
        left_child = 2 * i;
        right_child = 2 * i + 1;

        if left_child <= split_point
            A(i, left_child) = 1;
            A(left_child, i) = 1;
        end

        if right_child <= split_point
            A(i, right_child) = 1;
            A(right_child, i) = 1;
        end
    end

    % Define connections for a partial mesh topology (remaining nodes)
    for i = split_point + 1:K
        for j = i + 1:K
            if rand < 0.3  % Adjust the probability for density of the partial mesh
                A(i, j) = 1;
                A(j, i) = 1;
            end
        end
    end

    % Optionally, connect the two topologies at specific points to ensure they are connected
    A(1, split_point + 1) = 1;
    A(split_point + 1, 1) = 1;

% Since the adjacency matrix is symmetric for an undirected graph
A = A + A';

A = A'*0.9;
unstable=1;
while unstable==1
    lambda = eig(A);
    if any(abs(lambda)>1)
        unstable = 1;
        A = A*0.95;
    else
        unstable = 0;
    end
end

ntrans = 100; % transient period
wM = randn(K,n+ntrans);
xM = NaN*ones(K,n+ntrans);
P=1;
a0 = zeros(K,1);
xM(:,1:P) = wM(:,1:P);
for t=P+1:n+ntrans
    tmpV = a0;
    for i=1:P
        tmpV = tmpV + A(:,(i-1)*K+1:i*K)*xM(:,t-i);
    end   
    xM(:,t)=tmpV+wM(:,t);
end
xM = xM(:,ntrans+1:n+ntrans)';