clc; clear all; close all force;

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

[grid, queue, stop_condition] = percolation(N, mask, 0.5);

display(nansum(grid(:)), 'Cluster size');
% display(queue);
display(stop_condition);

plot_grid(grid, size(grid, 2), 'test.png');