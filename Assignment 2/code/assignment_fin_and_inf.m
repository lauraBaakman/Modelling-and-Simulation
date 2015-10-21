clc; clear all; close all force;

global stop_reasons
stop_reasons.PERCOLATING = 0;
stop_reasons.FINITE = 1;

Ns = [20];
ps = [0.3, 0.6, 0.5];
seeds = [8, 5, 8];

mask = ones(3,3);
mask(1,1) = 0;
mask(1,3) = 0;
mask(3,1) = 0;
mask(3,3) = 0;

idx = 1;

data = nan(size(ps, 1) * 20, 3);

for N = Ns
    for i = 1:length(ps)
        p = ps(i);
        seed = seeds(i);
            rng(seed);
            [grid, queue, ~] = percolation(N, mask, p);
            plot_grid(queue, grid, mask, size(grid, 2), sprintf('fancy_cluster_N%d_p%d_rng_%d.jpg', N, 10*p, seed));
    end
end

