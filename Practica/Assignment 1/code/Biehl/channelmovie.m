   function c = channelmovie(rmin,rmax,rinc,dt)

% channelmovie(rmin,rmax,rinc,dt)
% generates a sequence of channel plots for
% r-values between rmin and rmax {1}. r is 
% incremented by rinc {0.0001} after dt {1/50} sec.

   if nargin < 4 
      dt=1/50;
   end
   if nargin < 3
      rinc = 0.0001;
   end
   if nargin < 2
      rmax = 1;
   end

   number = floor( (rmax-rmin)/rinc )
 
   for i=1: floor( (rmax-rmin)/rinc) 
     r = rmin + i * rinc;
     channelplot(r)
     pause(dt)
   end
   

