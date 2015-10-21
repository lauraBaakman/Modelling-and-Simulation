clc; clear all; close all force;

N = 80;
p = 0.3;

stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;

four_mask = ones(3,3);
four_mask(1,1) = 0;
four_mask(1,3) = 0;
four_mask(3,1) = 0;
four_mask(3,3) = 0;

eight_mask = ones(3,3);

plotN = 16;

seed = 31;

% Generate cluster with four-connectivity
[grid_1, queue_1, stop_condition_1] = percolation(N, four_mask, p, seed);

% Generate cluster with eight-connectivity
[grid_2, queue_2, stop_condition_2] = percolation(N, eight_mask, p, seed);

%% Plot 
range = (N - plotN) : (N + plotN + 1);
plot_grid(queue_1, grid_1, four_mask, 216, sprintf('assignment_connectivity_four_N%d_p%d', N, round(p*10)), range);
plot_grid(queue_2, grid_2, eight_mask, 216, sprintf('assignment_connectivity_eight_N%d_p%d', N, round(p*10)), range);

%% Find a good seed value
% sizes = nan(100, 2);
%
% for seed = 1:100
% % Generate cluster with four-connectivity
% [grid_1, queue_1, stop_condition_1] = percolation(N, four_mask, p, seed);
%
% % Generate cluster with eight-connectivity
% [grid_2, queue_2, stop_condition_2] = percolation(N, eight_mask, p, seed);
%
%     if((stop_condition_1 == stop_reasons.FINITE)  && (stop_condition_2 == stop_reasons.FINITE))
% %         plot_grid(queue_1, grid_1, four_mask, 216, sprintf('assignment_connectivity_four_N%d_p%d', N, round(p*10)));
% %         plot_grid(queue_2, grid_2, eight_mask, 216, sprintf('assignment_connectivity_eight_N%d_p%d', N, round(p*10)));
%         sizes(seed, 1) = nansum(grid_1(:));
%         sizes(seed, 2) = nansum(grid_2(:));
%     end
% end
%
% [~, largest_difference_seed] = max(abs(sizes(:, 1) - sizes(:,2)));
% fprintf('Seed %d gives the larges difference between the two clusters.\n', largest_difference_seed);