function [ grid, sites ] = grow( grid, point, mask, p)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    
    top_row = point(2) - (size(mask, 1) - 1) / 2;
    bottom_row = point(2) + (size(mask, 1) - 1) / 2;
    left_col = point(1) - (size(mask, 2) - 1) / 2;
    right_col = point(1) + (size(mask, 2) - 1) / 2;
    
    sub_grid = grid(top_row:bottom_row, left_col:right_col);
    
    prob_mask = rand(size(mask)) .* mask;
    
    sub_grid = sub_grid + prob_mask;
    
    [rows, cols] = find(sub_grid <= p & mask);
    
    sub_grid(sub_grid > 1 | sub_grid <= p & mask) = 1;
    sub_grid(sub_grid ~=1 & sub_grid > p & mask) = NaN;
    
    grid(top_row:bottom_row, left_col:right_col) = sub_grid;
    
    sites = [rows, cols];
end


