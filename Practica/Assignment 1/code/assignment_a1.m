clc; clear all; close all force;

K = 1;
n = 10000;

X_IDX = 1; P_IDX = 2;

% x_rand = rand(1, 1);
% p_rand = rand(1, 1);

x_0 = [0.5, 0.1576131, 0.1269868];
p_0 = [0.5, 0.9705928, 0.9133759];

sizes = [100, 20, 15];

for idx = 1 : length(x_0)
    
    map = chirikov_map(K, x_0(idx), p_0(idx), n);
    
    figure()
    scatter(map(:, X_IDX), map(:, P_IDX), sizes(idx), 'filled');
    xlim([- 0.1, 1.1]);
    ylim([- 0.1, 1.1]);
    
    xlabel('{x_n}');
    ylabel('{p_n}');
    
    high_quality_plot('Save', sprintf('../report/img/assignment_a_%d_dim.pdf', idx - 1), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0.05);

end