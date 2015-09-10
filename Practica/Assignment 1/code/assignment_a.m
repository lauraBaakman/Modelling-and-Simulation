clc; clear all; close all force;

K = 1;
n = 1000;
num_runs = 1;

X_IDX = 1; P_IDX = 2;

initials = nan(num_runs, 2);

for idx = 1 : num_runs
%     x_0 = rand(1, 1);
%     p_0 = rand(1, 1);
    x_0 = 0.5;
    p_0 = 0.5;
    initials(idx, :) = [x_0, p_0];
    
    map = chirikov_map(K, x_0, p_0, n);
    
    hold on;
    scatter(map(:, X_IDX), map(:, P_IDX), 100, 'filled');
    xlim([- 0.1, 1.1]);
    ylim([- 0.1, 1.1]);
    
    xlabel('{x_n}');
    ylabel('{p_n}');
    
    high_quality_plot('Save', sprintf('../report/img/assignment_a_zero_dim_x0_%d_p0_%d.pdf', x_0*10, p_0*10), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0.05);
end
hold off;

save('../data/assignment_a_x0_p0', 'initials', 'num_runs', 'K', 'n', 'X_IDX', 'P_IDX');

%%
clc; clear all; close all force;

load('../data/assignment_a');

for idx = 1 : num_runs
    x_0 = initials(idx, X_IDX);
    p_0 = initials(idx, P_IDX);
    
    map = chirikov_map(K, x_0, p_0, n);
    
    hold on;
    scatter(map(:, X_IDX), map(:, P_IDX), 10, 'filled');
end
hold off;