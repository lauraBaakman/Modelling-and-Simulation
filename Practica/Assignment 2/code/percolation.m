function [ grid ] = percolation( N, mask, p )
    %PERCOLATION Summary of this function goes here
    %   Detailed explanation goes here
    
    
    grid = init_grid(N, mask)
    
    grid = remove_padding(grid, mask);
    
    
end


function [grid] = init_grid(N, mask)
    % Returns grid padded with mask.
    
    grid = zeros(2 * N + 1);
    grid(N+1, N+1) = 1;

    grid = padarray(grid, size(mask), NaN);
end


function [grid] = remove_padding(grid, mask)
    
    [padding_height, padding_width] = size(mask);
    
    grid = grid(1 + padding_height : end - padding_height, 1 + padding_width : end - padding_width);
end
