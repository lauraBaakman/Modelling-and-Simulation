clc; clear all; close all force;

Ks = 0:1/20:4;

X_IDX = 1; P_IDX = 2;

% x_0s = [0.5, 0.1576131, 0.1269868];
% p_0s = [0.5, 0.9705928, 0.9133759];

% x_0s = rand(1,3);
% p_0s = rand(1,3);

x_0s = 0.5179;
p_0s = 0.6505;

n = 1000;

marker.type = '.';
marker.size = 5;
marker.colour = lbmap(1, 'RedBlue');

for init_idx = 1:length(x_0s)
    
    x_0 = x_0s(init_idx);
    p_0 = x_0s(init_idx);

    maps = nan(n, 2, length(Ks));
    
    for idx = 1 : length(Ks)
        K = Ks(idx);
        maps(:, :, idx) = chirikov_map(K, x_0, p_0, n);
    end
    
        figure('Visible','off')
        scatter(reshape(repmat(Ks, n, 1), [], 1), reshape(squeeze(maps(:, X_IDX, :)), [], 1), marker.size, marker.colour, marker.type);
        xlabel('K')
        ylabel('{x_n}')
%         title(sprintf('x_0 = %2.3f, p_0 = %2.3f', x_0, p_0));
        high_quality_plot('Save', sprintf('../report/img/assignment_b_dim_%d_b_x', init_idx -1), 'Ext', 'jpeg', 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0, 'Box', 'on');
  
        figure('Visible','off')
        scatter(reshape(repmat(Ks, n, 1), [], 1), reshape(squeeze(maps(:, P_IDX, :)), [], 1), marker.size, marker.colour, marker.type);
        xlabel('K')
        ylabel('{p_n}')
%         title(sprintf('x_0 = %2.3f, p_0 = %2.3f', x_0, p_0));        
        high_quality_plot('Save', sprintf('../report/img/assignment_b_dim_%d_b_p', init_idx -1), 'Ext', 'jpeg', 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0, 'Box', 'on');
        
end