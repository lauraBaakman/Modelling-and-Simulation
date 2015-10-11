clc; clear all; close all force;

four_mask = ones(3,3);
four_mask(1,1) = 0;
four_mask(1,3) = 0;
four_mask(3,1) = 0;
four_mask(3,3) = 0;

four_mask(2,2) = 2;

colormap([[1, 1, 1]; lbmap(2, 'RedBlue')])


imagesc(four_mask);
axis off;
set(gca, 'position', [0 0 1 1]);
high_quality_plot('Save', '../report/img/exp_mask_four', 'Ext', 'jpeg', 'Dpi', 300, ...
'FontSize', 10, 'PaperSize', 0.4 * 216.32687, 'PaperWidthRatio', 1, 'PaperWidthHeightRatio', 1, 'Margin', 0);


colormap(lbmap(2, 'RedBlue'))
eight_mask = ones(3,3);
eight_mask(2,2) = 2;

imagesc(eight_mask );
axis off;
set(gca, 'position', [0 0 1 1]);
high_quality_plot('Save', '../report/img/exp_mask_eight', 'Ext', 'jpeg', 'Dpi', 300, ...
'FontSize', 10, 'PaperSize', 0.4 * 216.32687, 'PaperWidthRatio', 1, 'PaperWidthHeightRatio', 1, 'Margin', 0);