function [b] = LCET (g, b, E)

% Levin Campello E-tightness Algorithm

L = length(b);

S = sum((1./g) .* (2.^(b) - 1),'all');

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
    
    if E-S < 0
        n = find(EMAX == max(EMAX));
        S = S - e(b(n(1)),n(1));
        b(n(1)) = b(n(1)) - 1;
        
    else
        if E-S >= min(Emin)
            m = find(Emin == min(Emin));
            S = S + e(b(m(1))+1,m(1));
            b(m(1)) = b(m(1)) + 1;
            
        else
            break
        end
    end
end