function [n, r, FD, FA, LC] = fractalanalysis(c, varargin)
%FRACTALANALYSIS  factal analysis of a D-dimensional array (with D=1,2,3) 
%using box-counting and gliding-box methods.
%
%   [N, R, FD, FA, LC] = FRACTALANALYSIS(C, varargin), where 
%           c is a D-dimensional array (with D=1,2,3)
%           N is a vector of numbers of boxes
%           R is a vector of sizes of boxes
%           FD is fractal dimension
%           FA is fractal abundance
%           LC is Lacunarity calculated using gliding box method
%
%   The function counts the number N of D-dimensional boxes of size R 
%   needed to cover the nonzero elements of C. The box sizes are powers of 
%   two, i.e., R = 1, 2, 4 ... 2^P, where P is the smallest integer such that
%   MAX(SIZE(C)) <= 2^P. If the sizes of C over each dimension are smaller
%   than 2^P, C is padded with zeros to size 2^P over each dimension (e.g.,
%   a 320-by-200 image is padded to 512-by-512). The output vectors N and R
%   are of size P+1. For a RGB color image (m-by-n-by-3 array), a summation
%   over the 3 RGB planes is done first.
%
%   The Box-counting method is useful to determine fractal properties of a
%   1D segment, a 2D image or a 3D array. If C is a fractal set, with
%   fractal dimension DF < D, then N scales as R^(-DF). DF is known as the
%   Minkowski-Bouligand dimension, or Kolmogorov capacity, or Kolmogorov
%   dimension, or simply box-counting dimension.
%
%   FRACTALANALYSIS(C,'plot') also shows the log-log plot of N as a function of R
%   (if no output argument, this option is selected by default).
%
%   FRACTALANALYSIS(C,'slope') also shows the semi-log plot of the local slope
%   DF = - dlnN/dlnR as a function of R. If DF is contant in a certain
%   range of R, then DF is the fractal dimension of the set C. The
%   derivative is computed as a 2nd order finite difference (see GRADIENT).
%
%   The execution time depends on the sizes of C. It is fastest for powers
%   of two over each dimension.
%
%   Examples:
%
%      % Plots the box-count of a vector containing randomly-distributed
%      % 0 and 1. This set is not fractal: one has N = R^-2 at large R,
%      % and N = cste at small R.
%      c = (rand(1,2048)<0.2);
%      fractalanalysis(c);
%
%      % Plots the box-count and the fractal dimension of a 2D fractal set
%      % of size 512^2 (obtained by RANDCANTOR), with fractal dimension
%      % DF = 2 + log(P) / log(2) = 1.68 (with P=0.8).
%      c = randcantor(0.8, 512, 2);
%      fractalanalysis(c);
%      figure, fractalanalysis(c, 'slope');
%
%--------------------------------------------------------------------------
%   F. Moisy
%   Revision: 2.10,  Date: 2008/07/09
%--------------------------------------------------------------------------
%   Jun Li
%   Revision: 3.00,  Date: 2013/12/16
%--------------------------------------------------------------------------
% History:
% 2006/11/22: v2.00, joined into a single file boxcountn (n=1,2,3).
% 2008/07/09: v2.10, minor improvements
% 2012/12/16: v3.00, change boxcount to fractal analysis to produce factal
%             parameters: fractal dimension(FD), fractal abundance(FA), and
%             Lacunarity(LC).
%--------------------------------------------------------------------------
tic
LC = 0;

error(nargchk(1,2,nargin));

% checking to see if the pool is already open
% if matlabpool('size') == 0
%     matlabpool open 2
% end

% check for true color image (m-by-n-by-3 array)
if ndims(c)==3
    if size(c,3)==3 && size(c,1)>=8 && size(c,2)>=8
        c = sum(c,3);
    end
end

%warning off
c = logical(squeeze(c));
%warning on

dim = ndims(c); % dim is 2 for a vector or a matrix, 3 for a cube
if dim>3
    error('Maximum dimension is 3.');
end

% transpose the vector to a 1-by-n vector
if length(c)==numel(c)
    dim=1;
    if size(c,1)~=1   
        c = c';
    end   
end

width = max(size(c));    % largest size of the box
p = log(width)/log(2);   % nbre of generations

% remap the array if the sizes are not all equal,
% or if they are not power of two
% (this slows down the computation!)
p = ceil(p);
width = 2^p;
switch dim
    case 1
        mz = zeros(1,width);
        mz(1:length(c)) = c;
        c = mz;
    case 2
        mz = zeros(width, width);
        mz(1:size(c,1), 1:size(c,2)) = c;
        c = mz;
    case 3
        mz = zeros(width, width, width);
        mz(1:size(c,1), 1:size(c,2), 1:size(c,3)) = c;
        c = mz;            
end

r = 2.^(0:p); % box size (1, 2, 4, 8...)
n = zeros(1,p+1); % pre-allocate the number of box of size r
n(1) = sum(c(:));

switch dim
    case 1
        for g = 1:1:p
            siz = 2^g;
            %siz1 = fix(width/siz);
            %siz2 = mod(width/siz);
            for i=1:siz:(width-siz+1)
                t = c(i:(i+siz-1));
                n(g+1) = n(g+1) + any(t(:));
            end
        end
    case 2
        for g = 1:1:p
            siz = 2^g;
            for i=1:siz:(width-siz+1)
                for j=1:siz:(width-siz+1)
                    t = c(i:(i+siz-1), j:(j+siz-1));
                    n(g+1) = n(g+1) + any(t(:));
                end
            end
        end
    case 3
        for g = 1:1:p
            siz = 2^g;
            for i=1:siz:(width-siz+1),
                for j=1:siz:(width-siz+1),
                    for k=1:siz:(width-siz+1),
                        t = c(i:(i+siz-1), j:(j+siz-1), k:(k+siz-1));
                        n(g+1) = n(g+1) + any(t(:));
                    end
                end
            end
        end
end

[b, ~] = regress(log(n)', [ones(length(r), 1), log(1./r)'], 0.05);
FD = b(2); %slop
FA = b(1); %intercept
n1 = exp(FD * log(1./r)' + FA);

%============================lacunarity begin==============================
% v = ver;
% %any(strcmp('Parallel Computing Toolbox', {v.Name}))
% if(any(strncmpi('Parallel', {v.Name}, 8)))
%     LC = lacunarity3(c);
% else
%     LC = lacunarity(c);
% end

%============================plotting begin================================
if any(strncmpi(varargin,'slope',1))
    s=-gradient(log(n))./gradient(log(r));
    semilogx(r, s, 's-');
    ylim([0 dim]);
    xlabel('r, box size'); ylabel('- d ln n / d ln r, local dimension');
    title([num2str(dim) 'D box-count']);
elseif nargout==0 || any(strncmpi(varargin,'plot',1))
    %loglog(r,n,'s-');
    loglog(r, n, 'bo-', r, n1, 'r--');
    xlabel('r, box size'); ylabel('n(r), number of boxes');
    title([num2str(dim) 'D box-count']);
end

if nargout==0
    clear n
end

%matlabpool close
toc

end