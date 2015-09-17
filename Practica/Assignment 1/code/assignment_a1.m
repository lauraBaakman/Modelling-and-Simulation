clc; clear all; close all force;

K = 1;
n = 10000;

X_IDX = 1; P_IDX = 2;

x_0 = [0.5, 0.1576131, 0.1269868];
p_0 = [0.5, 0.9705928, 0.9133759];

colors = [
    27,158,119;
    217,95,2;
    117,112,179
    ] ./ 256;


number_of_plot_iterations = 500;

lbmap(2, 'RedBlue');

sizes = [100, 20, 15];

for idx = 1 : length(x_0)
    
    map = chirikov_map(K, x_0(idx), p_0(idx), n);
    
    %% Plot p vs x
        figure()
        scatter(map(:, X_IDX), map(:, P_IDX), sizes(idx), 'filled', 'MarkerFaceColor', colors(1,:));
        xlim([-0.1, 1.1]);
        ylim([-0.1, 1.1]);
    
        xlabel('{x_n}');
        ylabel('{p_n}');
    
        high_quality_plot('Save', sprintf('../report/img/assignment_a_%d_dim.pdf', idx - 1), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0.05, 'Box', 'on');
    
    %% Plot progression of x
        figure()
        plot(map(1:number_of_plot_iterations - 1, X_IDX), map(2:number_of_plot_iterations, X_IDX), 'Color', colors(2,:));
        xlim([-0.1, 1.1]);
        ylim([-0.1, 1.1]);
    
        xlabel('{x_n}');
        ylabel('{x_{n+1}}');
    
        high_quality_plot('Save', sprintf('../report/img/assignment_a_%d_dim_progression_x.pdf', idx - 1), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0.05, 'Box', 'on');
    
    %% Plot progression of p
        figure()
        if(idx == 1)
            scatter(map(1:number_of_plot_iterations - 1, P_IDX), map(2:number_of_plot_iterations, P_IDX), 100, 'Filled', 'MarkerFaceColor', colors(3,:));
        else
            plot(map(1:number_of_plot_iterations - 1, P_IDX), map(2:number_of_plot_iterations, P_IDX), 'Color', colors(3,:));
        end
    
        xlim([-0.1, 1.1]);
        ylim([-0.1, 1.1]);
    
        xlabel('{p_n}');
        ylabel('{p_{n+1}}');
    
        high_quality_plot('Save', sprintf('../report/img/assignment_a_%d_dim_progression_p.pdf', idx - 1), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 8, 'Margin', 0.05, 'Box', 'on');
    
    %% Plot period doubling x
%     if(idx ~= 1)
%         figure()
%         hist(map(:, X_IDX), 1250);
%         xlabel('{x_n}')
%         ylabel('frequency')
%         
%         %% Plot period doubling x
%         figure()
%         hist(map(:, P_IDX), 1250);
%         xlabel('{p_n}')
%         ylabel('frequency')        
    end
    
end