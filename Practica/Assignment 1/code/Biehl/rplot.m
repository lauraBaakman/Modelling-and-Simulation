    
     function rp = rplot(rmin,rmax,rinc,iter,iwaste)

% rplot(rmin,rmax,rinc,iter,iwaste)
% performs  iwaste {800} initial iterations of the
% logistic map, the follwing iter {200} steps are plotted 
% versus r in the range (rmin,rmax) with increment rinc {0.0001}

     if nargin < 5
        iwaste = 800;
     end
     if nargin < 4
        iter=200;
     end
     if nargin < 3
        rinc=0.0001; 
     end

%    number of r values
     nofr = floor( (rmax-rmin)/rinc); 

     rr=rmin*ones(1,nofr); 
     x =  ones(nofr,iter);

     for j=1:nofr 
       rr(j)= rmin + j* rinc; 
       x(j,1)=logstep(rr(j),0.2,100);
       for i=2:iter
           x(j,i) = logstep(rr(j),x(j,i-1),1);
       end
     end
     
     plot(rr, x(1:nofr,2:iter),'k.','MarkerSize',0.1)
     axis([rmin rmax 0.0 1.0]);

