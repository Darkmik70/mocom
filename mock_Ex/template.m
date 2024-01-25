%% Template Exam Modelling and Control of Manipulators
clc;
close all;
clear;
addpath('include'); % put relevant functions inside the /include folder 

%% Exercise 1
%% 1 Compute the geometric model for the given manipulator
geom_model = BuildTree(); %% 1
disp(geom_model);
numberOfLinks = size(geom_model,3); % number of manipulator's links.
linkType = zeros(numberOfLinks,1); % specify two possible link type: Rotational, Prismatic.

%% Given the following configuration compute the Direct Geometry for the manipulator
q = [0, -pi/2, -pi/2, 0, pi/2, 0]';
q0 = [0, 0, 0, 0, 0, 0]';

% Compute biTei : transformation between the base of the joint <i>
% and its end-effector taking into account the actual rotation/traslation of the joint
biTei_q0 = GetDirectGeometry(q0, geom_model, linkType);
disp('biTei_q0')
disp(biTei_q0);

biTei = GetDirectGeometry(q, geom_model, linkType);
disp('biTei')
disp(biTei);

%%
% Compute the transformation of the ee w.r.t. the robot base
bTe = GetTransformationWrtBase(biTei, 6);
disp('bTe')
disp(bTe)
%%
% Compute the transformation between frame <2> and frame <3>
iTj = GetFrameWrtFrame(biTei,2,3);
disp('2_T_3')
disp(iTj)
%%
% Compute the transformation between frame <6> and frame <3>
iTj = GetFrameWrtFrame(biTei,6,3)

iTj2 = GetFrameWrtFrame(biTei,3,6)
disp('6_T_3')
disp(iTj)
%%
%% Given the previous joint configuration compute the Jacobian matrix of the manipulator
J = GetJacobian(biTei, linkType);
disp('Jacobian Matrix for the given q*')
disp(J)

%% Exercise 2
%% Implement the inverse kinematic algorithm 

% Simulation variables
% simulation time definition 
ts = 0.001;
t_start = 0.0;
t_end = 10.0;
t = t_start:ts:t_end; 

% control proportional gain 
angular_gain = 0.8;
linear_gain = 0.8;

% preallocation variables
bTi= zeros(4, 4, numberOfLinks);
bri = zeros(3, numberOfLinks);
x_dot = zeros(6,1);
error_linear = zeros(3,1);
error_angular = zeros(3,1); 

% joints upper and lower bounds 
qmin = -3.14 * ones(6,1);
qmax = +3.14 * ones(6,1);

% initial configuration 
q = [pi/2 -pi/4 -pi/4 0 pi 0]';
 % recompute the bTe in this configuration
biTei = GetDirectGeometry(q, geom_model, linkType);
bTe = GetTransformationWrtBase(biTei, numberOfLinks);

% Goal definition 
bOg = [0.2 0 0.15]';


eRg_y = [cos(pi/6), 0, sin(pi/6);
          0,        1,     0;  
         -sin(pi/6), 0, cos(pi/6)];


eRg = eRg_y;

bRg = bTe(1:3,1:3) * eRg;
bTg=[bRg,bOg;
     0,0,0,1];
   
% Put true if you want to show the motion of the robot, false otherwise.
show_simulation = true;

% DO NOT EDIT plot specifications
figure
grid on 
hold on
title('MOTION OF THE MANIPULATOR')
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
az = 48;
el = 25;
view(az,el)
cindex = 1;
csize = length(t);
cmap = colormap(parula(csize));
color = cmap(mod(cindex,csize)+1,:);
plot3(bOg(1),bOg(2),bOg(3),'ro')

%%%%%%% Kinematic Simulation %%%%%%%
x_dot_hist = [];
t_hist = [];

for i = t
%%
    
    % computing transformation matrices for the new configuration 
    biTei = GetDirectGeometry(q, geom_model, linkType);
    % computing transformation matrix from base to end effector 
    bTe = GetTransformationWrtBase(biTei, numberOfLinks);
    % computing end effector jacobian 
    bJe = GetJacobian(biTei, linkType);

    % Compute the cartesian error to reach the goal
    error_linear = bOg-bTe(1:3,4); 

    bRe=bTe(1:3,1:3);
    [theta, v]=ComputeInverseAngleAxis(bRe'*bRg);
    rho = bTe(1:3,1:3) * (theta*v);
   

    %% Compute the reference velocities
    x_dot(1:3) = angular_gain*error_angular;
    x_dot(4:6) = linear_gain*error_linear;

    %% Compute desired joint velocities 
    q_dot = pinv(bJe)*x_dot;
    
	% simulating the robot
    q = KinematicSimulation(q, q_dot,ts, qmin, qmax);
	
	% computing the actual velocity - DO NOT EDIT
    x_dot_actual = bJe*q_dot;
    % saving the unitary direction for plot - DO NOT EDIT
    x_dot_hist = [x_dot_hist; (x_dot_actual/norm(x_dot_actual))'];
    t_hist = [t_hist; i];

    %% ... Plot the motion of the robot - DO NOT EDIT
	if (rem(i,0.1) == 0) % only every 0.1 sec
		for n =1:numberOfLinks
			bTi(:,:,n)= GetTransformationWrtBase(biTei,n);
		end

		bri(:,1) = [0; 0; 0];

		for j = 1:numberOfLinks
			bri(:,j+1) = bTi(1:3,4,j);
		end

		for j = 1:numberOfLinks+1
			plot3(bri(1,j), bri(2,j), bri(3,j),'bo')
		end

		color = cmap(mod(cindex,csize)+1,:);
		cindex = cindex + 1;
		line(bri(1,:), bri(2,:), bri(3,:), 'LineWidth', 1.5, 'Color', color)
	end
    
    if show_simulation == true
     drawnow
    end    
    
    if(norm(error_angular) < 0.01 && norm(error_linear) < 0.01)
        disp('REACHED REQUESTED POSE')
        break
    end
end

% Plot the final configuration of the robot - DO NOT EDIT
figure
grid on 
hold on
title('FINAL CONFIGURATION')
xlabel('x')
ylabel('y')
zlabel('z')
axis equal
az = 48;
el = 25;
view(az,el)
cindex = 1;
for j = 1:numberOfLinks+1
    plot3(bri(1,j), bri(2,j), bri(3,j),'bo')
end

color = cmap(mod(cindex,csize)+1,:);
cindex = cindex + 1;

line(bri(1,:), bri(2,:), bri(3,:), 'LineWidth', 1.5, 'Color', color)

figure
hold on;
title('DIRECTION OF THE END-EFFECTOR VELOCITIES')
plot(t_hist, x_dot_hist)
legend('omega x', 'omega y', 'omega z', 'xdot', 'ydot', 'zdot')
