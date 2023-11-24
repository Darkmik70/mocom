function [] = PlotConfiguration(biTei, linkType, qi, qf)
%%% PlotConfigurationDirectKinematic function

% Inputs:
% qi : Initial robot configuration
% qf : Final robot configuration
% geom_model : vector of frames 
% linkType : specifies two possible link types: Rotational [0], Prismatic
% [1]
% n : plot number (it is usefull to print in a for loop)

numberOfSteps = 100; % steps'number to pass from qi to qf







% Figure initialization 
figure
title("Configureation from Qi to Qf");
ax = axes('Parent', gcf); hold(ax, 'on');
axis equal; grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);






end