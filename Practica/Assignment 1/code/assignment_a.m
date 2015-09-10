clc; clear all; close all force;

K = 1;
n = 1000;
num_runs = 100;

X_IDX = 1; P_IDX = 2;

initials = nan(20, 2);

for idx = 1 : num_runs
    x_0 = rand(1, 1);
    p_0 = rand(1, 1);
    initials(idx, :) = [x_0, p_0];
    
    map = chirikov_map(K, x_0, p_0, n);
    
    hold on;
    scatter(map(:, X_IDX), map(:, P_IDX), 10, 'filled');
end
hold off;

save('../data/assignment_a', 'initials', 'num_runs', 'K', 'n', 'X_IDX', 'P_IDX');

%%
clc; clear all; close all force;

load('../data/assignment_a');

for idx = 1 : num_runs
    x_0 = initials(idx, X_IDX);
    p_0 = initials(idx, P_IDX);
    
    map = chirikov_map(K, x_0, p_0, n);
    
    hold on;
    scatter(map(:, X_IDX), map(:, P_IDX), 10, 'filled');
end
hold off;