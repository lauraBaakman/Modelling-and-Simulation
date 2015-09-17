
   function r = channelplot(rr,bins,iter,iwaste,top)

% channelplot(r,bins,iter,iwaste)
% performs iwaste {1000} initial iterations of 
% the logistic map with paramater  r, 
% then generates a histogram for the occurence
% of x-values in the subsequent iter {10000} steps,
% bins {1000} controls the number of bins
% top  {iter/100} is the maximal occurence displayed  

   if nargin < 2 
      bins=1000;
   end
   if nargin < 3 
      iter=10000;
   end
   if nargin < 4 
      iwaste=1000;
   end
   if nargin < 5 
      top = iter/100 ;
   end
         
   x= 0.1 * ones(1,iter);
   x(1) = logstep(rr,0.2,iwaste+1);
   for i=2:iter
       x(i)= logstep(rr,x(i-1),1);
   end

   plot(0,0); 
   axis ([0 1 0 top]);
   title([ 'r = ' num2str(rr,'%0.5f')],'FontSize',18);
   hold on;
   hist(x,bins);
   hold off;

