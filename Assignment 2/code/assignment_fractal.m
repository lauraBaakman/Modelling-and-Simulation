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
plot_grid(queue, grid, mask, 216, 'assignment_fractal_cluster');

% Prepare data for boxcount
boxcount_grid = grid;
boxcount_grid(isnan(boxcount_grid)) = 0;

% Do boxcounting
[num_boxes, box_size] = boxcount(boxcount_grid);

%% Plot
close all force;
color = lbmap(1);

loglog(box_size, num_boxes, '-o' ,'lineWidth', 2, 'color', color, 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', 3);
xlabel('{log[\epsilon]}')
ylabel('{log[N(\epsilon)]}')

high_quality_plot2('Save', '../report/img/assignment_fractal_numboxesVSboxsize', 'Dpi', 300, ...
        'FontSize', 10, 'PaperSize', 443, 'PaperWidthRatio', 0.3, 'PaperWidthHeightRatio', 1);

%% Plot the gradient
s=-gradient(log(num_boxes))./gradient(log(box_size));
semilogx(box_size, s, '-' ,'lineWidth', 2, 'color', color);
ylim([0 2]);
xlabel('{log[\epsilon}]');
ylabel('{Local dimension}');
high_quality_plot2('Save', '../report/img/assignment_fractal_gradient', 'Dpi', 300, ...
    'FontSize', 10, 'PaperSize', 443, 'PaperWidthRatio', 0.3, 'PaperWidthHeightRatio', 1);