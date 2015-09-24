clc; clear all; close all force;

num_runs = 100;
num_iter = 1000;

ks = [0, 0.2, 0.4, 0.8, 1, 2, 3, 4];

colors = lbmap(num_runs, 'RedBlue');

for k = ks
    figure('name', sprintf('k = %d', k));
    hold on;
    for run = 1 : num_runs
        x_0 = rand(1,1);
        p_0 = rand(1,1);
        
        map = chirikov_map(k, x_0, p_0, num_iter);
        scatter(map(:, 1), map(:, 2), 5, 'filled', 'MarkerFaceColor', colors(run, :));
    end
    hold off;
 
    set(gca, 'visible', 'off');
    high_quality_plot('Save', sprintf('../report/img/assignment_b_fancy_k_%d', round(k*10)), 'FontSize', 22, 'PaperWidth', 4, 'PaperHeight', 4, 'Margin', 0.05);
    
    close all;
end


