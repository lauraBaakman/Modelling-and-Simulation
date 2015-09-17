clc; clear all; close all force;

K = 0:1/100:3;

X_IDX = 1; P_IDX = 2;

x_0 = [0.5, 0.1576131, 0.1269868];
p_0 = [0.5, 0.9705928, 0.9133759];

n = 1000;

for init_idx = 1: length(x_0)
    
    maps = nan(n, 2, length(K));
    
    for idx = 1 : length(K)
        
        map = chirikov_map(K(idx), x_0(init_idx), p_0(init_idx), n);
       
    end
    
    figure()
        scatter(reshape(repmat(K, n, 1), [], 1), reshape(squeeze(maps(:, X_IDX, :)), [], 1));
    
    figure()
        scatter(reshape(repmat(K, n, 1), [], 1), reshape(squeeze(maps(:, P_IDX, :)), [], 1));
        
end