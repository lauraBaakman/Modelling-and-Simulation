
   function s = iterplot(r,xinit,nsteps)

% function iterplot(r,xinit,nsteps)
% performs nsteps iterations of the logistic map
% with parameter r and plots
% a)  the x-values vs. "time"
% b)  the sequence of x-values as x(i) vs x(i-1)


   x= xinit * ones(1,nsteps);
   xprev = x;
   time = 1 : nsteps;
 
   for i=2:nsteps
      x(i) = logstep(r,x(i-1),1);
      xprev(i) = x(i-1);
   end

   plot(time,x,'k-*')
   title([' r = ' num2str(r,'%0.4f')],'FontSize',18);
   axis([ 0 nsteps+1  -0.01  1.01 ]) ;
   axis square;


   figure;
   x1= ones(1,2*nsteps-2);
   x2= ones(1,2*nsteps-2); 

   for i=1:nsteps-1
        x1(2*i-1) = x(i);
        x2(2*i-1) = x(i);
        x1(2*i)   = x(i); 
        x2(2*i)   = x(i+1);
   end
        
   plot(x1(2:2*nsteps-2),x2(2:2*nsteps-2));
   hold on;
   fplot(r,1);
   title([' r = ' num2str(r,'%0.4f')], 'FontSize',18);
   axis square;
   hold off;
 
