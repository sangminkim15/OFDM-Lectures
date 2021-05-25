function [] = main ()

u = zeros(2,1);
P = [400, 0 ; 0, 100];

syms x y;
f = (x-2).^2 + (y-4).^2;

df = [diff(f,x) ; diff(f,y)];

EllipsoidMethod(df, u, P, 40);

end