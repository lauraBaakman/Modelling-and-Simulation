clc; clear all; close all;

grid = zeros(3,3);
grid(2,2) = 1;

grid(1,1) = NaN;
grid(1,2) = NaN;
grid(2,1) = 1;

display(grid)

mask_eight = ones(3,3);
mask_four = ones(3,3);
mask_four(1,1) = 0;
mask_four(1,3) = 0;
mask_four(3,1) = 0;
mask_four(3,3) = 0;

N = 3;
p = 0.5;


[grid, queue] = percolation(3, mask_four, 0.5);
plotGrid(grid, 100, sprintf('../report/img/grid_p%d_N%d.png', round(p * 100), N));

