
  function s = logstep(r,x,n) 

% logstep.m defines the logistic map
% logstep(r,x,n) iterates 4*r*x*(1-x) n times
% beginning with initial value x

  for i=1:n 
       x = 4 * r * x * (1-x); 
  end
  s=x;

    
