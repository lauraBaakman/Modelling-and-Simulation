clc; clear all; close all force;

K = 1;
n = 1000;
num_runs = 1000;

colors = lbmap(num_runs, 'RedBlue');

X_IDX = 1; P_IDX = 2;

initials = rand(num_runs, 2);

for idx = 1 : num_runs
    x_0 = initials(idx, X_IDX);
    p_0 = initials(idx, P_IDX);
    
    map = chirikov_map(K, x_0, p_0, n);
    
    xlabel('{x_n}');
    ylabel('{p_n}');    
    
    hold on;
    scatter(map(:, X_IDX), map(:, P_IDX), 5, 'filled', 'MarkerFaceColor', colors(idx, :));
end
set(gca,'visible','off');
high_quality_plot('Save', sprintf('../report/img/assignment_a_pretty.pdf'), 'FontSize', 22, 'PaperWidth', 4, 'PaperHeight', 4, 'Margin', 0.05, 'Box', 'on');

hold off;
close all force;