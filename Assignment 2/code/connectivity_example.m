clc; clear all; close all force;

N = 80;
p = 0.7;

stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;

four_mask = ones(3,3);
four_mask(1,1) = 0;
four_mask(1,3) = 0;
four_mask(3,1) = 0;
four_mask(3,3) = 0;

eight_mask = ones(3,3);


seed = 7;

% Generate cluster with four-connectivity
[grid, queue, stop_condition] = percolation(N, four_mask, p, seed);
plot_grid(queue, grid, four_mask, 216, 'assignment_connectivity_four.jpeg');

if(stop_condition == stop_reasons.PERCOLATING)
    error('The cluster is percolating, try a different seed!');
end

% Generate cluster with eight-connectivity
[grid, queue, stop_condition] = percolation(N, eight_mask, p, seed);
plot_grid(queue, grid, eight_mask, 216, 'assignment_connectivity_eight.jpeg');
if(stop_condition == stop_reasons.PERCOLATING)
    error('The cluster is percolating, try a different seed!');
end