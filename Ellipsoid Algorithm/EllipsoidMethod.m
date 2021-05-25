function [] = EllipsoidMethod (df, u, P, N)

i = 0;
[n,~] = size(u);

while i < N
    gs = zeros(n,1);
    for j = 1 : n
        gs(j) = subs(df(j),u(j));
    end
    g = double(gs);
    
    gtilde = sqrt(1 / (g' * P * g)) * g;
    u = u - (1/(n+1)) * P * gtilde;
    P = (n.^2/(n.^2-1)) * (P - (2/(n+1)) * P * (gtilde * gtilde') * P');
    
    i = i + 1;
    
    EllipsoidPlot(u, P^(-1));
end

hold off;

end