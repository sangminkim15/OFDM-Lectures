function [] = main ()

% MAIN FUNCTION %

% Tx : transmitted symbol blocks in freq domain
%   10 Symbol Blocks
%   Symbol Length = 64
%   4QAM Modulation
%   x : transmitted symbol blocks in time domain

Tx = cell(1,10);
x = cell(1,10);
for j = 1 : 10
    Tx{1,j} = randi([0,1], 1, 64) + 1i * randi([0,1], 1, 64);
    Tx{1,j} = 2 * Tx{1,j} - (1 + 1i);
    
    x{1,j} = ifft(Tx{1,j});
end

% Channel
%   Channel Length = 7
%   h : channel in time domain

h = [ones(1,7), zeros(1,57)];

% Adding Cyclic Prefix
%   X1 : Prefix Length = 5 
%   X2 : Prefix Length = 7 
%   X3 : Prefix Length = 9 

x1 = cell(1,10);
x2 = cell(1,10);
x3 = cell(1,10);

for j = 1 : 10
    sequence = x{1,j};
    prefix1 = zeros(1,4);
    prefix2 = zeros(1,6);
    prefix3 = zeros(1,8);
    
    for l = 1 : 4
        prefix1(l) = sequence(1,l+60);
    end
    
    for l = 1 : 6
        prefix2(l) = sequence(1,l+58);
    end
    
    for l = 1 : 8
        prefix3(l) = sequence(1,l+56);
    end
    
    x1{1,j} = [prefix1, sequence];
    x2{1,j} = [prefix2, sequence];
    x3{1,j} = [prefix3, sequence];   
end

% Channel Output

x1m = cell2mat(x1);
x2m = cell2mat(x2);
x3m = cell2mat(x3);

z1m = conv(x1m, h);
z2m = conv(x2m, h);
z3m = conv(x3m, h);

y1m = zeros(1, length(x1m));
y2m = zeros(1, length(x2m));
y3m = zeros(1, length(x3m));

for p = 1 : length(x1m)
    y1m(p) = z1m(p);
end

for p = 1 : length(x2m)
    y2m(p) = z2m(p);
end

for p = 1 : length(x3m)
    y3m(p) = z3m(p);
end

y1 = m2c(y1m, 10);
y2 = m2c(y2m, 10);
y3 = m2c(y3m, 10);

% Remove Cyclic Prefix
%   y : received symbol blocks in time domain

for j = 1 : 10
    z1 = y1{1,j};
    z2 = y2{1,j};
    z3 = y3{1,j};
    
    sequence1 = zeros(1,64);
    sequence2 = zeros(1,64);
    sequence3 = zeros(1,64);
    
    for l = 1 : 64
        sequence1(1,l) = z1(1,l+4);
        sequence2(1,l) = z2(1,l+6);
        sequence3(1,l) = z3(1,l+8);
    end
       
    y1{1,j} = sequence1;
    y2{1,j} = sequence2;
    y3{1,j} = sequence3;
end

% Rx : received symbol blocks in freq domain

Rx1 = cell(1,10);
Rx2 = cell(1,10);
Rx3 = cell(1,10);

for j = 1 : 10
    Rx1{1,j} = fft(y1{1,j}) ./ fft(h);
    Rx2{1,j} = fft(y2{1,j}) ./ fft(h);
    Rx3{1,j} = fft(y3{1,j}) ./ fft(h);
end

% Tx/Rx Plot of Symbol Block 1

subplot(2,2,1);
plot(Tx{1,1}, '*');
title('Transmitted Signal');
xlim([-2 2]);
ylim([-2 2]);
grid on;

subplot(2,2,2);
plot(Rx1{1,1}, '*');
title('Received Signal, Prefix Length = 5')
xlim([-2 2]);
ylim([-2 2]);
grid on;

subplot(2,2,3);
plot(Rx2{1,1}, '*');
title('Received Signal, Prefix Length = 7')
xlim([-2 2]);
ylim([-2 2]);
grid on;

subplot(2,2,4);
plot(Rx3{1,1}, '*');
title('Received Signal, Prefix Length = 9')
xlim([-2 2]);
ylim([-2 2]);
grid on;

% Decision / Error Rate

e1 = zeros(1,10);
e2 = zeros(1,10);
e3 = zeros(1,10);

for j = 1 : 10
    e1(j) = ErrorRate (1+1i, -1+1i, -1-1i, 1-1i, Tx{1,j}, Rx1{1,j});
    e2(j) = ErrorRate (1+1i, -1+1i, -1-1i, 1-1i, Tx{1,j}, Rx2{1,j});
    e3(j) = ErrorRate (1+1i, -1+1i, -1-1i, 1-1i, Tx{1,j}, Rx3{1,j});
end

Index = {'Channel Length = 5'; 'Channel Length = 7'; 'Channel Length = 9'};
Block1 = [e1(1); e2(1); e3(1)];
Block2 = [e1(2); e2(2); e3(2)];
Block3 = [e1(3); e2(3); e3(3)];
Block4 = [e1(4); e2(4); e3(4)];
Block5 = [e1(5); e2(5); e3(5)];
Block6 = [e1(6); e2(6); e3(6)];
Block7 = [e1(7); e2(7); e3(7)];
Block8 = [e1(8); e2(8); e3(8)];
Block9 = [e1(9); e2(9); e3(9)];
Block10 = [e1(10); e2(10); e3(10)];
Average = [mean(e1,2); mean(e2,2); mean(e3,2)];
T = table(Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Block9, Block10, Average, 'RowNames', Index);
disp(T);

end