clc; clear all; close all force;
% Influence of cluster size

% stop_conditions niet zo robuust, dus deze ints niet veranderen!
global stop_reasons
stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;
    
ns = 2:2:60;
p = 0.5;
max_runs = 200;

mask = ones(3,3);

num_ns = length(ns);
clusters_stats = struct('sizes', ns, ...
                        'means', nan(num_ns, 1), ...
                        'stds', nan(num_ns, 1), ...
                        'finite_ratio', nan(num_ns, 1));
                    
tic
for n_idx = 1 : length(ns);
    cluster_sizes = nan(max_runs, 1);
    stop_conditions = nan(max_runs, 1);
    N = ns(n_idx);
    parfor run = 1 : max_runs
        [grid, queue, stop_condition] = percolation(N, mask, p);
        stop_conditions(run) = stop_condition;
        cluster_sizes(run) = nansum(grid(:));
    end
    stop_conditions = logical(stop_conditions);
    clusters_stats.means(n_idx) = mean(cluster_sizes(stop_conditions) / (N + 1)^2);
    clusters_stats.stds(n_idx) = std(cluster_sizes(stop_conditions) / (N + 1)^2);
    clusters_stats.finite_ratio(n_idx) = mean(stop_conditions);
end
toc

%% Plot Finite cluster means
close all
figure('name', 'Mean and std as function of N');
color = lbmap(1, 'RedBlue');

errorbar(clusters_stats.means, clusters_stats.stds, ...
    'o', 'MarkerFaceColor', color, 'MarkerEdgeColor', color, 'MarkerSize', 4, ...
    'LineWidth', 2, 'Color', color, ...
    'Clipping', 'off');

ylim([min(clusters_stats.means - clusters_stats.stds), max(clusters_stats.means + clusters_stats.stds)]);

xlim([0, 30.5]);
set(gca, 'XTick', (2:2:length(ns)));
set(gca, 'XTickLabel', ns(2:2:length(ns)));
set(gca, 'XMinorTick', 'on');

xlabel('(N + 1)^2');
ylabel('Q');

high_quality_plot('Save', '../report/img/assignment_d_mean_std_n', 'Dpi', 300, ...
    'FontSize', 10, 'PaperSize', 442.65375, 'PaperWidthRatio', 1.0, 'PaperWidthHeightRatio', 0.5);

%% Plot P_infinite
close all;
figure('name', 'Inifinite cluster ratio as function of N');
color = lbmap(1, 'RedBlue');

plot(1 - clusters_stats.finite_ratio, 'LineWidth', 2, 'Color', color);

xlabel('N');
ylabel('{P_\infty}');

xlim([0, 30]);
set(gca, 'XTick', (2:4:length(ns)));
set(gca, 'XTickLabel', ns(2:4:length(ns)));
set(gca, 'XMinorTick', 'on');

high_quality_plot('Save', '../report/img/assignment_d_p_infinite_ratio_N', 'Dpi', 300, ...
    'FontSize', 10, 'PaperSize', 216.32687, 'PaperWidthRatio', 1.0, 'PaperWidthHeightRatio', 0.75);