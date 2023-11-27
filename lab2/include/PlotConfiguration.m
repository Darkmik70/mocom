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
axis equal; grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);


for i = 1:numberOfSteps


    % Get Coressponding vectors
    for i = 1:numberOfLinks
        bri(:,i) = GetBasicVectorWrtBase(geom_model, i);
    end

    plot3(bri);

end





end