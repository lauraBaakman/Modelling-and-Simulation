clc; clear all; close all force;

% stop_conditions niet zo robuust, dus deze ints niet veranderen!
global stop_reasons
stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;
    
N = 20;
ps = (0.3:0.01:0.7);
max_runs = 200;

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

num_ps = length(ps);
clusters_stats = struct('probabilities', ps, ...
                        'means', nan(num_ps, 1), ...
                        'stds', nan(num_ps, 1), ...
                        'finite_ratio', nan(num_ps, 1));
                    
tic
for p_idx = 1 : length(ps);
    cluster_sizes = nan(max_runs, 1);
    stop_conditions = nan(max_runs, 1);
    for run = 1 : max_runs
        [grid, queue, stop_condition] = percolation(N, mask, ps(p_idx));
        stop_conditions(run) = stop_condition;
        cluster_sizes(run) = nansum(grid(:));
    end
    stop_conditions = logical(stop_conditions);
    clusters_stats.means(p_idx) = mean(cluster_sizes(stop_conditions));
    clusters_stats.stds(p_idx) = std(cluster_sizes(stop_conditions));
    clusters_stats.finite_ratio(p_idx) = mean(stop_conditions);
end
toc

%% Plot Finite cluster means
figure('name', 'Mean and std as function of p');
color = lbmap(1, 'RedBlue');

errorbar(clusters_stats.means, clusters_stats.stds, ...
    'o', 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', 8, ...
    'LineWidth', 3, 'Color', color, ...
    'Clipping', 'off');

ylim([min(clusters_stats.means - clusters_stats.stds) - 10, max(clusters_stats.means + clusters_stats.stds) + 10]);
% set(gca, 'YTick', linspace(0, N * 2 + 1, (N * 2 + 1) / length(ps)));

xlim([0, 42]);
set(gca, 'XTick', (1:10:length(ps)));
set(gca, 'XTickLabel', ps(1:10:length(ps)));
set(gca, 'XMinorTick', 'on');

xlabel('p');
ylabel('Mean cluster size');

high_quality_plot('Save', '../report/img/assignment_a_mean_std_p', 'Ext', 'pdf', 'Dpi', 300, 'FontSize', 22, 'PaperWidth', 12, 'PaperHeight', 8, 'Margin', 0.05);

%% Plot P_infinite
figure('name', 'Inifinite cluster ratio as function of p');
color = lbmap(1, 'RedBlue');

plot(1 - clusters_stats.finite_ratio, 'LineWidth', 2, 'Color', color);

xlabel('p');
ylabel('{P_\infty}');

high_quality_plot('Save', '../report/img/assignment_a_mean_std_p', 'Ext', 'pdf', 'Dpi', 300, 'FontSize', 22, 'PaperWidth', 12, 'PaperHeight', 8, 'Margin', 0.05);


