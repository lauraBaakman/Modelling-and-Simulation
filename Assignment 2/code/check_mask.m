function [ ] = check_mask( mask )
    %CHECK_MASK Summary of this function goes here
    %   Detailed explanation goes here
    
    even = @(x) mod(x, 2) == 0;
    
    [r, c] = size(mask);
    
    if even(r) || even(c)
        error('Dimensions of mask need to be odd.');
    end
end

