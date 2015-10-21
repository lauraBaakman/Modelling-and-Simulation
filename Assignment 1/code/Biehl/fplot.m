
   function fp = fplot(r,n)

% fplot(r,n) plots the n-fold iteration  of the
% logistic map with paramter r (default: n=1)
% (includes  f(x)=x for n=0)

   if nargin==1 
        n=1;
   end

   x = 0:0.001:1;
   y = x;
   for i =1:n
        y = 4*r* y .* (1-y) ;
   end

   plot(x,y,'k-'); hold on;
   plot(x,x,'k-'); hold off;


  
