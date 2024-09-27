function G = randomNG(n)
G = round(rand(n));
G = triu(G) + triu(G,1)';
G = G - diag(diag(G));