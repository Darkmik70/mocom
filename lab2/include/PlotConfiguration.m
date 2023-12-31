function [fig1, fig2] = PlotConfiguration(q_i, q_f,geom_model,linkType)
%PLOT Summary of this function goes here
%   Detailed explanation goes here

% FK
Qi = GetDirectGeometry(q_i, geom_model, linkType);
Qf = GetDirectGeometry(q_f, geom_model, linkType);


% Plot Qi
fig1 = figure;
title("Plot Configuration q_i"); view(3);
grid on; hold on; axis equal; grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([-450 700]); ylim([-450 700]); zlim([0 700]);
xlabel('[mm]');ylabel('[mm]');zlabel('[mm]');

% Create handle for a sample joint and line for legend
jointHandle = plot3(0, 0, 0, 'k.', 'MarkerSize', 15); % Handle for joints
lineHandle = line([0,0], [0,0], [0,0], 'LineWidth', 2.5, 'Color', "#4DBEEE"); % Handle for lines


% We assume that size of Qi is equal to Qf TODO add some test
numberOfLinks = size(Qi,3);


% allocate basic vector
bri = zeros(3,numberOfLinks);

% Get Coressponding vectors 
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(Qi, i);
end

plot3(0,0,0,'k.', 'MarkerSize',30)

% Plot positions 
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(Qi, i);
    % Plot joints as points 
    plot3(bri(1,i),bri(2,i),bri(3,i), 'k.', 'MarkerSize', 15)
end

% plot connection from base to link 1 
base = [0,0,0; 0, 0, bri(3,1)]'; %%kinda softcoded
line(base(1,:),base(2,:),base(3,:),'LineWidth',2.5,'Color', "#4DBEEE");
% plot rest of the links 
line(bri(1,:),bri(2,:),bri(3,:),'LineWidth',2.5,'Color', "#4DBEEE");

legend([jointHandle, lineHandle], {'Joint', 'Link'}, 'Location', 'best');

% do Qf

fig2 = figure;
title("Plot Configuration q_f"); view(3);
grid on; hold on; axis equal; grid on; hold on;
xlabel('X'); ylabel('Y'); zlabel('Z');
xlim([-450 700]); ylim([-450 700]); zlim([0 700]);
xlabel('[mm]');ylabel('[mm]');zlabel('[mm]');

% Create handle for a sample joint and line for legend
jointHandle = plot3(0, 0, 0, 'k.', 'MarkerSize', 15); % Handle for joints
lineHandle = line([0,0], [0,0], [0,0], 'LineWidth', 2.5, 'Color', "red"); % Handle for lines


% allocate basic vector
bri = zeros(3,numberOfLinks);

% Get Coressponding vectors 
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(Qf, i);
end

plot3(0,0,0,'k.', 'MarkerSize',30)

% Plot positions 
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(Qf, i);
    % Plot joints as points 
    plot3(bri(1,i),bri(2,i),bri(3,i), 'k.', 'MarkerSize', 15)
end

% plot connection from base to link 1 
base = [0,0,0; 0, 0, bri(3,1)]'; %%kinda softcoded
line(base(1,:),base(2,:),base(3,:),'LineWidth',2.5,'Color', "red");
% plot rest of the links 
line(bri(1,:),bri(2,:),bri(3,:),'LineWidth',2.5,'Color', "red");

legend([jointHandle, lineHandle], {'Joint', 'Link'}, 'Location', 'best');

end


