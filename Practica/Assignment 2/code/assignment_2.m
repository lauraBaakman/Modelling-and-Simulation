clc; clear all; close all force;

global stop_reasons
stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;

rng(314159);

Ns = [5, 20];
ps = [0.3, 0.7];

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

for N = Ns
    for p = ps
        [grid, queue, stop_condition] = percolation(N, mask, p);
        plot_grid(queue, grid, mask, size(grid, 2), sprintf('fancy_cluster_N%dp_%d.jpg', N, 10*p));
    end
end

