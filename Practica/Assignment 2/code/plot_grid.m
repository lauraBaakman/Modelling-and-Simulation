
% NAN: Leeg, mag niet gebruikt -> grijs
% 0: Leeg, beschikbaar         -> zwart
% 1: vol                       -> wit (1!)

function [] = plot_grid(queue, grid, mask, pixelWidth, filename)
    queue = fix_queue(queue, mask);

    colours = generate_colors(grid);
    
    colour_grid = 0.5 * ones(size(grid, 1), size(grid, 2), 3);
    
    % Set used squares to colours
    colour_grid = fill_color_grid(colour_grid, queue(:,1), queue(:,2), colours);
    
    % Set unavailble not used squares to black
    [row_empty_not_available, col_empty_not_available] = find(isnan(grid)); 
    colour_grid = fill_color_grid(colour_grid, row_empty_not_available, col_empty_not_available, ones(size(row_empty_not_available, 1), 3));    
    
%     figure('name', 'Colour')
    colour_grid = imresize(colour_grid, [NaN pixelWidth], 'nearest');
    
    imagesc(colour_grid);
    axis off;
    set(gca, 'position', [0 0 1 1]);
    high_quality_plot('Save', sprintf('../report/img/map_%d_%d', size(grid, 1), size(grid, 2)), 'Ext', 'jpeg', 'Dpi', 300, ...
    'FontSize', 10, 'PaperSize', 442.65375, 'PaperWidthRatio', 0.24, 'PaperWidthHeightRatio', 1, 'Margin', 0);
%     imshow(colour_grid, 'InitialMagnification', 'fit');
%     imwrite(colour_grid, filename);
    
%     figure('name', 'Black and White')
%     grid = fix_values(grid);
%     grid = imresize(grid, [NaN pixelWidth], 'nearest');
%     imshow(grid, 'InitialMagnification', 'fit');
%     imwrite(colour_grid, filename);
end

function [colors] = generate_colors(grid)
    numberOfFilledLocations = sum(grid(:) == 1);
    start_colour = [11, 91, 180] ./ 256;
    end_colour = [178, 0, 2] ./ 256;
    colors = colorRamp([start_colour; end_colour], numberOfFilledLocations);
end

function [queue] = fix_queue(queue, mask)
    % Remove nan from queue
    queue = reshape(queue(~isnan(queue)), [], 2);
    
    % Set queue to image space instead of padded image space
    [rows, cols] = mask_size(mask);
    queue(:,1) = queue(:,1) - rows;
    queue(:,2) = queue(:,2) - cols;
end

function [grid] = fill_color_grid(grid, rows, cols, colours)
    dimensionOnes = ones(size(colours, 1),1);
    for dim = 1:3
        grid(sub2ind(size(grid),rows,cols, dim * dimensionOnes)) = colours(:, dim);
    end
end

function [grid] = fix_values(grid)
%     grid(grid == 0) = 0.5;
    grid(isnan(grid)) = 0.5;    
end

