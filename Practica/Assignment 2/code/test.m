function [] = test()
 
queue = init_queue(10, 2)

is_empty(queue)

queue = push(queue, rand(11, 2));

is_empty(queue)

elem = pop(queue)

is_empty(queue)
    
end

function [bool] = is_empty(queue)
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