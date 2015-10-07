clc; clear all; close all force;

N = 80;
p = 0.7;

% For seed in 1..100 38 gives the largest finite cluster
rng(38)

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

% Generate finite cluster
[grid, ~, stop_condition] = percolation(N, mask, p);

[num_boxes, box_size] = boxcount(grid);

% loglog(box_size, num_boxes,'s-');



