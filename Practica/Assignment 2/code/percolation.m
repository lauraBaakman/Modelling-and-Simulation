function [ grid, queue ] = percolation( N, mask, p )
    %PERCOLATION Summary of this function goes here
    %   Detailed explanation goes here
    
    check_mask(mask);
    
    [grid, site, max_sites] = init_grid(N, mask);
    
%     global site_idx queue_end;
    queue = init_queue(round(max_sites * p), 2);
    queue = push(queue, site);
    
    while ~stop(grid(site(1), site(2)))
        [grid, next_sites] = grow(grid, site, mask, p);
        
        queue = push(queue, next_sites);
        
        if on_border(site, grid, mask)
            break;
        end

        site = pop(queue);
        if(isempty(site))
            break;
        end
    end
    
    grid = remove_padding(grid, mask);
end

function [site] = pop(queue)
    global site_idx queue_end;
    site_idx = site_idx + 1;
    if site_idx >= queue_end
        site = {};
    else
        site = queue(site_idx, :);
    end
end

function [queue] = init_queue(rows, cols)
    global site_idx queue_end;
    site_idx = 1;
    queue_end = 1;
    queue = nan(rows, cols);
end

function [queue] = push(queue, elements)
    global queue_end;
    queue(queue_end:queue_end + size(elements, 1) - 1, :) = elements;
    queue_end = queue_end + size(elements, 1);
end

function [b] = on_border(site, grid, mask)
    [mask_width, mask_height] = mask_size(mask);
    
    left_border = 1 + mask_width;
    right_border = size(grid, 2) - mask_width;
    
    top_border = 1 + mask_height;
    bottom_border = size(grid, 1) - mask_height;
    
    b = (site(1) == top_border || site(1) == bottom_border) || ...
        (site(2) == left_border || site(2) == right_border);
end

function [b_stop] = stop(site)
    b_stop = isnan(site);
end


function [grid, center, max_sites] = init_grid(N, mask)
    % Returns grid padded with mask.
    
    center = [N + 1, N + 1];
    size = 2 * N + 1;
    max_sites = size^2;
    
    grid = zeros(size);
    grid(center(1), center(2)) = 1;
    
    [padding_rows, padding_cols] = mask_size(mask);
    grid = padarray(grid, [padding_rows, padding_cols], NaN);
    
    center = center + [padding_rows, padding_cols];
end


function [grid] = remove_padding(grid, mask)
    [padding_rows, padding_cols] = mask_size(mask);
    
    grid = grid(1 + padding_rows : end - padding_rows,...
        1 + padding_cols : end - padding_cols);
end
