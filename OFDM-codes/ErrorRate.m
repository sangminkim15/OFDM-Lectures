function [e] = ErrorRate (x1, x2, x3, x4, Tx, Rx)

e = 0;
x = zeros(1, length(Rx));

for i = 1 : length(Rx)
    if min([abs(Rx(i)-x1), abs(Rx(i)-x2), abs(Rx(i)-x3), abs(Rx(i)-x4)]) == abs(Rx(i) - x1)
        x(i) = x1;
    else
        if min([abs(Rx(i)-x1), abs(Rx(i)-x2), abs(Rx(i)-x3), abs(Rx(i)-x4)]) == abs(Rx(i) - x2)
            x(i) = x2;
        else
            if min([abs(Rx(i)-x1), abs(Rx(i)-x2), abs(Rx(i)-x3), abs(Rx(i)-x4)]) == abs(Rx(i) - x3)
                x(i) = x3;
            else
                x(i) = x4;
            end
        end
    end
    
    if abs(x(i) - Tx(i)) > 1e-4
        e = e + 1;
    end
end

e = e / length(Rx);
    
end