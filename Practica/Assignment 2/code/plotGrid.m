function [] = plotGrid(grid, pixelWidth, filename)
    grid = fix_values(grid);
    grid = imresize(grid, [NaN pixelWidth], 'nearest');
    imshow(grid, 'InitialMagnification', 'fit');
    imwrite(grid, filename)
end

function [grid] = fix_values(grid)
    grid = swap_zeros_and_ones(grid);
    grid(isnan(grid)) = 0.5;    
end

function [grid] = swap_zeros_and_ones(grid)
   grid = 1 - grid; 
end

