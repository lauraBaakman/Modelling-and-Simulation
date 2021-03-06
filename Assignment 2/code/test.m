clc; clear all; close all force;

global stop_reasons
stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;
    
% rng(3);

% N = 5;
% ps = (0.3:0.01:0.7);
% max_runs = 200;

N = 1000;
% ps = 0.6;
% max_runs = 200;

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

tic
[grid, queue, stop_condition] = percolation(N, mask, 0.6);
toc

plot_grid(queue, grid, mask, size(grid, 2), 'test.png');