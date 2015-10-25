function [ grid, sites ] = grow( grid, site, mask, p, probabilities)
    %GROW Performs a single iteration of the percolation
    %   Returns the grid after single itteration growth has been calculated
    %   on the grid(site), using the mask en probability p.
    
    [mask_height, mask_width] = mask_size(mask);
    
    top_row = site(1) - mask_height;
    bottom_row = site(1) + mask_height;
    left_col = site(2) - mask_width;
    right_col = site(2) + mask_height;
    
    sub_grid = grid(top_row:bottom_row, left_col:right_col);
    sub_prob = probabilities(top_row:bottom_row, left_col:right_col);
      
    prob_mask = sub_prob .* mask;
    
    sub_grid = sub_grid + prob_mask;
    
    [rows, cols] = find(sub_grid <= p & mask);
    
    sub_grid(sub_grid > 1 | sub_grid <= p & mask) = 1;
    sub_grid(sub_grid ~=1 & sub_grid > p & mask) = NaN;
    
    grid(top_row:bottom_row, left_col:right_col) = sub_grid;
    
    sites = repmat([top_row, left_col], size(rows, 1), 1) + ([rows, cols] - 1);
end


