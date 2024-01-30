% Author Michal Krepa 6475383
%% Template Exam Modelling and Control of Manipulators
clc;
close all;
clear;
addpath('include'); % put relevant functions inside the /include folder 

%% Compute the geometric model for the given manipulator
geom_model = BuildTree();
disp('Geometric Model')
disp(geom_model);
numberOfLinks = size(geom_model,3); % number of manipulator's links.
linkType = [0 0 0 0 0 1 0 0]; % specify the link type for all joints: Rotational = 0, Prismatic = 1.

%% Given the following configuration compute the Direct Geometry for the manipulator
q = [0, 0, 0, 0, 0, 0, 0, 0]';

% Compute biTei : transformation between the base of the joint <i>
% and its end-effector taking into account the actual rotation/traslation of the joint
biTei = GetDirectGeometry(q, geom_model, linkType);
disp('biTei')
disp(biTei);

% Compute the transformation of the ee w.r.t. the robot base
bTe = GetTransformationWrtBase(biTei, 8);
disp('bTe')
disp(bTe)

%% Given the previous joint configuration compute the Jacobian matrix of the manipulator
J = GetJacobian(biTei, bTe, linkType);
disp('Jacobian Matrix for the given q')
disp(J)

% Tool frame definition
  eTt = [0 0 -1 -0.11;
         0 1 0 0;
         1 0 0 0.060;
         0 0 0 1]; 

bTt = bTe * eTt;

disp("eTt");
disp(eTt);
disp('bTt q = 0');
disp(bTt);


%% Inverse Kinematic

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
bTi = zeros(4, 4, numberOfLinks);
bri = zeros(3, numberOfLinks);
x_dot = zeros(6,1);
error_linear = zeros(3,1);
error_angular = zeros(3,1); 

% joints upper and lower bounds
qmin = -3.14 * ones(8,1);
qmin(6) = 0;
qmax = +3.14 * ones(8,1);
qmax(6) = 1;

% initial configuration 
q = [pi/2, -pi/4, 0, -pi/4, 0, 0.15, pi/4, 0]';
% recompute the bTe and bTt in this configuration
biTei = GetDirectGeometry(q, geom_model, linkType);
bTe = GetTransformationWrtBase(biTei, numberOfLinks);
bTt = bTe * eTt;
disp('bTt q = initial config');
disp(bTt);

% Goal definition 
bOg = [0.15 -0.85 0.3]';
bRg = rot_y(pi/2);
bTg = [bRg , bOg; 0 0 0 1]
disp('bTg');
disp(bTg);

% Show simulation ? 
show_simulation = true;
% tool must be used, do not change
tool = true;

% visualization, do not change
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
% initialization of variables for plots, do not change
x_dot_hist = [];
t_hist = [];
for i = t
    % computing transformation matrices for the new configuration 
    biTei = GetDirectGeometry(q, geom_model, linkType);
    % computing transformation matrix from base to the tool
    bTe = GetTransformationWrtBase(biTei, numberOfLinks);
    bTt = bTe * eTt;
    % computing the tool jacobian 
    bJe = GetJacobian(biTei, bTe, linkType);
    
    % Rigid body Jacobian
    r = [0 -bTt(3,4), bTt(2,4);
        bTt(3,4) 0 -bTt(1,4);
        -bTt(2,4), bTt(1,4), 0];
    S = [eye(3), zeros(3); r, eye(3)];
    bJt = S * bJe;

    % Compute the cartesian error to reach the goal
    [lin_err, theta, v] = ComputeError(bTt,bTg);

    error_linear = lin_err;
    error_angular = bTt(1:3,1:3) * (theta*v);
    error = [error_angular; error_linear];

    %% Compute the reference velocities'
    big_lambda = [ angular_gain * eye(3), zeros(3,3);
                   zeros(3,3), linear_gain * eye(3)];
   
    x_dot = big_lambda * error; % Goal velocity is zero

    %% Compute desired joint velocities 
     q_dot = pinv(bJt) * x_dot;

    % computing the actual velocity and saving the unitary direction for plot
    % do NOT change
    x_dot_actual = bJt*q_dot;
    x_dot_hist = [x_dot_hist; (x_dot_actual/norm(x_dot_actual))'];
    t_hist = [t_hist; i];

    % simulating the robot
    q = KinematicSimulation(q, q_dot, ts, qmin, qmax);

    %% ... Plot the motion of the robot 
    if (rem(i,0.1) == 0) % only every 0.1 sec
        for n =1:numberOfLinks
            bTi(:,:,n)= GetTransformationWrtBase(biTei,n);
        end
    
        bri(:,1) = [0; 0; 0];
    
        for j = 1:numberOfLinks
            bri(:,j+1) = bTi(1:3,4,j);
            if tool == true
                brt = bTt(1:3,4);
                bri(:,j+2) = brt;
            end
    
        end
    
        for j = 1:numberOfLinks+1
            plot3(bri(1,j), bri(2,j), bri(3,j),'bo')
            if tool == true
                plot3(brt(1),brt(2),brt(3),'go')
            end
        end
    

        plot3([bTt(1,4) bTt(1,4)+0.1*bTt(1,1)], [bTt(2,4) bTt(2,4)+0.1*bTt(2,1)], [bTt(3,4) bTt(3,4)+0.1*bTt(3,1)],'r')
        plot3([bTt(1,4) bTt(1,4)+0.1*bTt(1,2)], [bTt(2,4) bTt(2,4)+0.1*bTt(2,2)], [bTt(3,4) bTt(3,4)+0.1*bTt(3,2)],'g')
        plot3([bTt(1,4) bTt(1,4)+0.1*bTt(1,3)], [bTt(2,4) bTt(2,4)+0.1*bTt(2,3)], [bTt(3,4) bTt(3,4)+0.1*bTt(3,3)],'b')

        color = cmap(mod(cindex,csize)+1,:);
        cindex = cindex + 1;
    
        line(bri(1,:), bri(2,:), bri(3,:), 'LineWidth', 1.5, 'Color', color)
    end
    if show_simulation == true
        drawnow
    end
    %% 

    % these variables should be updated in order to understand if the robot  
    % has reached the desired configuration
    if(norm(error_angular) < 0.01 && norm(error_linear) < 0.01)
        disp('REACHED REQUESTED POSE')        
        break
    end

end

%%Plot the final configuration of the robot
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
    if tool == true
        plot3(brt(1),brt(2),brt(3),'go')
    end
end

color = cmap(mod(cindex,csize)+1,:);
cindex = cindex + 1;

line(bri(1,:), bri(2,:), bri(3,:), 'LineWidth', 1.5, 'Color', color)

figure
hold on;
title('DIRECTION OF THE END-EFFECTOR VELOCITIES')
plot(t_hist, x_dot_hist)
legend('omega x', 'omega y', 'omega z', 'xdot', 'ydot', 'zdot')
