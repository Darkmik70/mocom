function [] = PlotAnimate(qi, qf,geom_model,linkType)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

numberOfSteps = 100;

% For each single link we want to separate the path in n steps.
qSteps = [linspace(qi(1),qf(1),numberOfSteps)',...
          linspace(qi(2),qf(2),numberOfSteps)',...
          linspace(qi(3),qf(3),numberOfSteps)',...
          linspace(qi(4),qf(4),numberOfSteps)',...
          linspace(qi(5),qf(5),numberOfSteps)',...
          linspace(qi(6),qf(6),numberOfSteps)',...
          linspace(qi(7),qf(7),numberOfSteps)'];


% Plot Qi
figure
title("Plot Configuration q_i"); view(3);
grid on; hold on; axis equal; grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([-450 850]); ylim([-550 850]); zlim([-100 850]);


for i = 1:numberOfSteps
    cla;
    %-------------------MOVE----------------------%
    % we need to calculate fk for qsteps(1,:)

    conf = GetDirectGeometry(qSteps(i,:), geom_model, linkType);

    % We assume that size of Qi is equal to Qf TODO add some test
    numberOfLinks = size(conf,3);
    % allocate basic vector
    bri = zeros(3,numberOfLinks);
    % Get Coressponding vectors
    for i = 1:numberOfLinks
        bri(:,i) = GetBasicVectorWrtBase(conf, i);
    end

    plot3(0,0,0,'k.', 'MarkerSize',30)

    % Plot positions
    for j = 1:numberOfLinks
        bri(:,j) = GetBasicVectorWrtBase(conf, j);
        % Plot joints as points
        plot3(bri(1,j),bri(2,j),bri(3,j), 'k.', 'MarkerSize', 15)
    end

    % plot connection from base to link 1
    base = [0,0,0; 0, 0, bri(3,1)]'; %%kinda softcoded
    line(base(1,:),base(2,:),base(3,:),'LineWidth',2.5,'Color', "#4DBEEE");
    % plot rest of the links
    line(bri(1,:),bri(2,:),bri(3,:),'LineWidth',2.5,'Color', "#4DBEEE");
    drawnow;
end
