clc; clear all; close all force;

K = 0;
x_0s = [0.5, 0.1576131, 0.1269868];
p_0s = [0.5, 0.9705928, 0.9133759];

% To not get confused
X_IDX = 1; P_IDX = 2;

x_0 = x_0s(1);
p_0 = p_0s(1);

n = 1000;

for i = 1:length(x_0)
    map = chirikov_map(K, x_0s(i), p_0(i), n);
    
    figure()
    plot(1:500, map(1:500, X_IDX));
    xlabel('n');
    ylabel('{x_n}');

    figure()
    plot(1:500, map(1:500, P_IDX));
    xlabel('n');
    ylabel('{p_n}');
    
    figure()
    plot(map(:, X_IDX), map(:, P_IDX));
    xlabel('{x_n}');
    ylabel('{p_n}');
    
end