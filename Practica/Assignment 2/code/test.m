clc;

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

[grid, sites] = grow(grid, [2,2], mask_four, 0.5);

display(grid)
display(sites)