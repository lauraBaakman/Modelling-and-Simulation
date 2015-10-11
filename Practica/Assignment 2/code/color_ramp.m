function cmap = color_ramp(colors, nlevels)
% colorRamp produces a color ramp for use in figure colormaps
%   cmap = colorRamp(colors, nlevels)
%
%   Interpolates between color stops specified in the m-by-3 matrix colors.
%   Each row represents one color stop.
%   Assumes color stops are equally spaced.
%
%   By default, produces a cmap with 32-levels, unless the nlevels argument
%   is supplied.

% number of defined color stops
nstops = size(colors, 1);

cmap = interp1(colors, linspace(1,nstops,nlevels));