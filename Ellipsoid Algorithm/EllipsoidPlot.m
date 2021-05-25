function [] = EllipsoidPlot (u, E)

R = chol(E);
t = linspace(0, 2*pi, 100);
z = [cos(t); sin(t)];
ellipse = R \ z;

for i = 1 : 100
    ellipse(:,i) = ellipse(:,i) + u;
end

subplot(1,2,1);
plot(ellipse(1,:), ellipse(2,:), 'LineWidth', 1.5);
title('Ellipsoid Plots');
xlabel('x-axis');
ylabel('y-axis');
xlim([-15 25]);
ylim([-15 25]);
grid on;
hold on;

subplot(1,2,2);
plot(u(1), u(2), '*', 'LineWidth', 1.5);
title('Center Points');
xlabel('x-axis');
ylabel('y-axis');
xlim([-1 7]);
ylim([-1 7]);
grid on;
hold on;
end