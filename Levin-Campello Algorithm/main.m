function [] = main ()

% MAIN FUNCTION

g = [1/2, 1/3, 1/4, 1/5];
b = [2, 2, 0, 0];
E = 12;

b = LCEF(g, b);
b = LCET(g, b, E);

ginv = (1./g);
S = ginv .* (2.^(b) - 1);

BAR = [ginv ; S]';

subplot(1,2,1);
bar(BAR, 'stacked');
xlabel('subchannel');
ylabel('1/g_n & E_n');

title('Power');
legend('1/g_n = \sigma_n^2/|h|_n^2', 'E_n');


subplot(1,2,2);
bar(b);
xlabel('subchannel');
ylabel('b_n');

title('# of Bits per Subchannel');


sgtitle('Levin-Campello Loading Algorithm');

end