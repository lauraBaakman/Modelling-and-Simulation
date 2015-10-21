function [ height, width ] = mask_size( mask )
    %MASK_LIM return height and width from center.
    
    height = (size(mask, 1) - 1) / 2;
    width = (size(mask, 2) - 1) / 2; 
end

