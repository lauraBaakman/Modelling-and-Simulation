
% NAN: Leeg, mag niet gebruikt -> grijs
% 0: Leeg, beschikbaar         -> zwart
% 1: vol                       -> wit (1!)

function [] = plot_grid(grid, pixelWidth, filename)
    grid = fix_values(grid);
    grid = imresize(grid, [NaN pixelWidth], 'nearest');
    imshow(grid, 'InitialMagnification', 'fit');
    imwrite(grid, filename)
end

function [grid] = fix_values(grid)
%     grid(grid == 0) = 0.5;
    grid(isnan(grid)) = 0.5;    
end

