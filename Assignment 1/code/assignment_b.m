clc; clear all; close all force;

num_runs = 5;
K = linspace(0, 1, num_runs);
n = 1000;

x_0 = rand(1, 1);
p_0 = rand(1, 1);

X_IDX = 1; P_IDX = 2;

for idx = 1 : num_runs
    
    map = chirikov_map(K(idx), x_0, p_0, n);
    
    figure('name', sprintf('Plot K = %d', K(idx)));
    scatter(map(:, X_IDX), map(:, P_IDX), 10, 'filled');
end

save('../data/assignment_b', 'num_runs', 'K', 'x_0', 'p_0', 'n', 'X_IDX', 'P_IDX');

%%
clc; clear all; close all force;

load('../data/assignment_b');

for idx = 1 : num_runs
    map = chirikov_map(K(idx), x_0, p_0, n);
    
    figure('name', sprintf('Plot K = %d', K(idx)));
    scatter(map(:, X_IDX), map(:, P_IDX), 10, 'filled');
end