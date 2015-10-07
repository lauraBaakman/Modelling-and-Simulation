function high_quality_plot( varargin )
    
    p = inputParser;
    p.FunctionName = 'high_quality_plot';
    p.CaseSensitive = false;
    
    % TODO (better) validators....
    % add optional needs the name, default value, and validator
    p.addOptional('Save', '');
    
    p.addOptional('Ext', 'pdf', @check_extension);
    
    function tf = check_extension(x)
        tf = ischar(x) && (strcmp('pdf', x) || strcmp('jpeg', x)); % Lazy?
    end
    
    p.addOptional('Dpi', 300, @check_dpi);
    
    function tf = check_dpi(x)
        tf = isnumeric(x) && (x > 0 && x < 1200); % Ofzo....
    end

    p.addOptional('PaperSize', 345, @isnumeric);
    p.addOptional('PaperWidthRatio', 1, @isnumeric);
    p.addOptional('PaperWidthHeightRatio', 1, @isnumeric);
%     p.addOptional('Margin', 0.1, @isnumeric);
    p.addOptional('FontSize', 10, @isnumeric);
    p.addOptional('Box', 'off');
    p.addOptional('Axis', 'normal');
    
    parse(p, varargin{:});
    
    validFontNames = {'AvantGarde'; 'Bookman'; 'Courier'; 'Helvetica'; ...
		'Helvetica-Narrow'; 'NewCenturySchoolBook'; 'Palatino'; ...
		'Symbol'; 'Times'; 'ZapfChancery'; 'ZapfDingbats'};
    fontname = char(validFontNames(6));
    
    % gca = the handle to the current axis in the current figure. set(0,'defaulttextinterpreter','latex');
    set(get(gca, 'xlabel'), 'FontSize', p.Results.FontSize, 'FontWeight', 'Normal', 'FontName', fontname);
    set(get(gca, 'ylabel'), 'FontSize', p.Results.FontSize, 'FontWeight', 'Normal', 'FontName', fontname);
    set(get(gca, 'title') , 'FontSize', p.Results.FontSize, 'FontWeight', 'Normal', 'FontName', fontname);
    
    % box on; adds a box to the current axes. box off takes it off
    if strcmp(p.Results.Box, 'off')
        box off;
    else
        box on;
    end
    
    % square axes box (equal, image, normal, vis3d, on, off)
    if strcmp(p.Results.Axis, 'square')
        axis square;
    else
        axis normal;
    end
    
    % more (better) defaults for the axes
    set(gca, 'LineWidth', 1, ...
             'FontSize', p.Results.FontSize, ...
             'FontWeight', 'Normal',...
             'FontName', fontname);
         
    set(legend, 'FontSize', p.Results.FontSize, 'FontName', fontname);
    set(legend, 'FontWeight', 'Normal', 'FontName', fontname);
    legend boxoff;
    
    set(gca,'FontName', fontname);
    set(findall(gcf,'type','text'),'FontName', fontname);
    
    % gcf = the handle to the current figure
%     set(gcf, 'color', 'w', ...  
%              'PaperUnits', 'inches', ...
%              'PaperSize', [p.Results.PaperWidth, p.Results.PaperHeight], ...
%              'PaperPosition', [p.Results.Margin ...
%                                p.Results.Margin ...
%                                p.Results.PaperWidth - 2 * p.Results.Margin ...
%                                p.Results.PaperHeight - 2 * p.Results.Margin]);

    margin = 1;
    paper_width = p.Results.PaperWidthRatio * p.Results.PaperSize;
    paper_height = paper_width * p.Results.PaperWidthHeightRatio;
    
    set(gcf, 'color', 'w', ...  
             'PaperUnits', 'points', ...
             'PaperSize', [paper_width, paper_height], ...
             'PaperPosition', [margin ...
                               margin ...
                               paper_width - 2 * margin ...
                               paper_height - 2 * margin]);
                   
    
    set(gcf, 'PaperPositionMode', 'Manual');
    
    if ~strcmp(p.Results.Save, '')
        print(gcf, '-painters', sprintf('-d%s', p.Results.Ext), sprintf('-r%d', p.Results.Dpi), p.Results.Save);
    end
end