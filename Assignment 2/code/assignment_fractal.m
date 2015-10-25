clc; clear all; close all force;

% rng(38);

N = 200;
ps = 0.3:0.1:0.7;
number_of_runs = 20;

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;

mean_fractal_dimension = nan(size(ps, 1), 1);

number_of_runs = 20;
ps = 0.3:0.1:0.6;

p_idx = 1;
for p = ps
    fractal_dimensions_run = nan(10, 1);
    p_idx
    for run = 1:number_of_runs
        while true
            % Generate cluster
            [grid, queue, stop_condition] = percolation(N, mask, p);
            
            % If the cluster is finite             
            if(stop_condition == stop_reasons.FINITE)
                % Prepare data for boxcount
                boxcount_grid = grid;
                boxcount_grid(isnan(boxcount_grid)) = 0;
                
                % Do boxcounting
                [~, ~, fractal_dimensions_run(run), ~, ~] = fractalanalysis(boxcount_grid);
                break;
            end
        end
    end
    mean_fractal_dimension(p_idx) = nanmean(fractal_dimensions_run);
    p_idx = p_idx + 1;
end

%% Plot
color = lbmap(1, 'RedBlue');

figure('name', 'Box counting dimension as function of p');

plot(ps, mean_fractal_dimension, ...
       'o-', 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', 4,...
       'LineWidth', 2, 'Color', color, ...
       'Clipping', 'off');       
xlabel('{p}')
ylabel('{\rho}')


hq_plot('Save', './../report/img/assignment_fractal_rhoVSp.png', 'Dpi', 300, ...
        'FontSize', 10, 'PaperSize', 216, 'PaperWidthRatio', 1, 'PaperWidthHeightRatio', 1);