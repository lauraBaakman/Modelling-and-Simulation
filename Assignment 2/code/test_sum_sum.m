
grid = randi([0 1], 10000, 10000);

tic 
sum(sum(grid));
toc

tic
sum(grid(:));
toc