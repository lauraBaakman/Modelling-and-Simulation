function [ map ] = chirikov_map( K, x_0, p_0, n )
    %CHIRIKOVMAP Summary of this function goes here
    %   Detailed explanation goes here
    
    % To not get confused
    X_IDX = 1; P_IDX = 2;
    
    % Init Chirikov map
    map = nan(n, 2);
    
    % Initial x and p values.
    map(1, :) = [x_0, p_0];
    
    for it = 2 : n
        map(it, P_IDX) = mod(map(it - 1, P_IDX) + K * sin(2 * pi * map(it - 1, X_IDX)) / (2 * pi), 1);
        map(it, X_IDX) = mod(map(it - 1, X_IDX) + map(it, P_IDX), 1);
    end
end