clc; clear all; close all force;

p_0 = 0.9999999;
% x_0s = 0:0.1:1;
x_0s = 0.000001;

hold on
for x_0 = x_0s
    map = chirikov_map(0, x_0, p_0, 9999999999);
    plot(1:length(map(:,1)), map(:,1));
end
hold off