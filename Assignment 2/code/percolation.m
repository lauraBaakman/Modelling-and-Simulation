function [ grid, queue, stop_reason] = percolation( N, mask, p )
    %PERCOLATION Summary of this function goes here
    %   Detailed explanation goes here
    
    global stop_reasons
    stop_reasons.PERCOLATING = 0;
    stop_reasons.FINITE = 1;
    
    check_mask(mask);
    
    [grid, site, max_sites] = init_grid(N, mask);
    
    stop_reason = {};
    
    queue = init_queue(round(max_sites * p), 2);
    queue = push(queue, site);
    
    probabilities = rand(size(grid));
    
    while ~is_empty(queue)
        site = pop(queue);
        
        [grid, next_sites] = grow(grid, site, mask, p, probabilities);
        
        if on_border(next_sites, grid, mask)
            stop_reason = stop_reasons.PERCOLATING;
            % fprintf('Terminating, since percolating.');
            break;
        end

        queue = push(queue, next_sites);
    end
    if(isempty(stop_reason))
        stop_reason = stop_reasons.FINITE;
        % fprintf('Terminating, since finite.');
    end
    grid = remove_padding(grid, mask);
    
end

function [bool] = is_empty(~)
    global site_idx queue_end;
    bool = site_idx >= queue_end;
end

function [site] = pop(queue)
    global site_idx;
    if is_empty(queue)
        site = {};
    else
        site = queue(site_idx, :);
    end
    site_idx = site_idx + 1;
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

function [b] = on_border(sites, grid, mask)
    [mask_width, mask_height] = mask_size(mask);
    
    left_border = 1 + mask_width;
    right_border = size(grid, 2) - mask_width;
    
    top_border = 1 + mask_height;
    bottom_border = size(grid, 1) - mask_height;
    
    b = (sites(:, 1) == top_border | sites(:, 1) == bottom_border) | ...
        (sites(:, 2) == left_border | sites(:, 2) == right_border);
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
