clc; clear all; close all force;

N = 80;
p = 0.7;

% For seed in 1..100 38 gives the largest finite cluster for N = 100 and p
% = 0.7
rng(38)

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

% Generate finite cluster
[grid, queue, stop_condition] = percolation(N, mask, p);

%% Plot cluster before we edit the grid
plot_grid(queue, grid, mask, 216, 'assignment_fractal_cluster.jpeg');

% Prepare data for boxcount
grid(isnan(grid)) = 0;

% Do boxcounting
[num_boxes, box_size] = boxcount(grid);

%% Plot 
close all force;
color = lbmap(1);

loglog(box_size, num_boxes, '-o' ,'lineWidth', 2, 'color', color, 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', 5);
xlabel('{\epsilon}')
ylabel('{N(\epsilon)}')

high_quality_plot('Save', '../report/img/assignment_fractal_numboxesVSboxsize', 'Ext', 'pdf', 'Dpi', 300, ...
    'FontSize', 10, 'PaperSize', 216.32687, 'PaperWidthRatio', 1.0, 'PaperWidthHeightRatio', 1);