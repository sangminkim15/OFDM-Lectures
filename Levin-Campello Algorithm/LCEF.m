function [b] = LCEF (g, b)

% Levin-Campello Effientizing Algorithm
L = length(g);

e = zeros(100, L);

for i = 1 : 100
    e(i,:) = (1./g) .* (2.^((i-1) * ones(1,L)));
end

while true
    Emin = zeros(1,L);
    EMAX = zeros(1,L);
            
    for j = 1 : L
        Emin(j) = e(b(j)+1,j);
        if b(j) ~= 0
            EMAX(j) = e(b(j),j);
        end
    end
    
    m = find(Emin == min(Emin));
    n = find(EMAX == max(EMAX));
    
    if min(Emin) < max(EMAX)
        b(m(1)) = b(m(1)) + 1;
        b(n(1)) = b(n(1)) - 1;
    else
        break
    end

end