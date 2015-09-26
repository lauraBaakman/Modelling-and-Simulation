clc; clear all; close all force;

num_runs = 100;
num_iter = 1000;

ks = [0, 0.2, 0.4, 0.8, 1, 2, 3, 4];

% colors = lbmap(num_runs, 'RedBlue');

for k = ks
    figure('name', sprintf('k = %d', k));
    hold on;
    for run = 1 : num_runs
        x_0 = rand(1,1);
        p_0 = rand(1,1);
        
        map = chirikov_map(k, x_0, p_0, num_iter);
        scatter(map(:, 1), map(:, 2), 5, 'filled', 'MarkerFaceColor', [0.5 x_0 p_0]);
    end
    hold off;
 
    set(gca, 'visible', 'off');
    high_quality_plot('Save', sprintf('../report/img/assignment_b_fancy_k_%d', round(k*10)), 'FontSize', 22, 'PaperWidth', 4, 'PaperHeight', 4, 'Margin', 0.05);
    
    close all;
end


%% Color map
[x, p] = meshgrid(0:0.01:1, 0:0.01:1);

color_g = x(:);
color_b = p(:);
color_r = repmat(0.5, length(color_g), 1);

colors = [color_r, color_g, color_b];

scatter(x(:), p(:), [], colors, 's', 'filled')

xlabel('{x_n}');
ylabel('{p_n}');

high_quality_plot('Save', '../report/img/assignment_b_colormap', 'FontSize', 22, 'PaperWidth', 4, 'PaperHeight', 4, 'Margin', 0.05);

