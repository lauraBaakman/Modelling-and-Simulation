clc; clear all; close all force;

%% Vary x_0

p_0 = 0.4;
x_0s = 0.1:0.2:1;
    
colors = lbmap(1);

idx = 1;
for x_0 = x_0s
    map = chirikov_map(0, x_0, p_0, 20);
    plot(1:length(map(:,1)), map(:,1), 'lineWidth', 2, 'color', colors);
    idx = idx + 1;
    xlabel('n');
    ylabel('{x_n}')
    high_quality_plot('Save', sprintf('../report/img/assignment_b_K=0p_0=04x_0=0%d.pdf', round(x_0*10)), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 2, 'Margin', 0, 'Box', 'on');
end


%% Vary p_0

p_0s = 0.1:0.2:1;
x_0 = 0.4;
    
colors = lbmap(1);


idx = 1;
for p_0 = p_0s
    map = chirikov_map(0, x_0, p_0, 20);
    plot(1:length(map(:,1)), map(:,1), 'lineWidth', 2, 'color', colors);
    idx = idx + 1;
    xlabel('n');
    ylabel('{x_n}')
    high_quality_plot('Save', sprintf('../report/img/assignment_b_K=0p_0=0%dx_0=04.pdf', round(p_0*10)), 'FontSize', 22, 'PaperWidth', 8, 'PaperHeight', 2, 'Margin', 0, 'Box', 'on');
end