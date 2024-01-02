clc; clear; close all;
addpath('include')
model = load("panda.mat"); % don't worry about eventual warnings!
%% Modelling and Control of Manipulator assignment 3 - Exercise 2 and 3: Inverse Kinematic Control

% Simulation Parameters
ts = 0.5;
t_start = 0.0;
t_end = 30.0;
t = t_start:ts:t_end;

% Initial Joints configuration
q_init = [0.0167305, -0.762614, -0.0207622, -2.34352, -0.0305686, 1.53975, 0.753872]';

% Joint limits
qmin = [-2.8973; -1.7628; -2.8973; -3.0718; -2.8973; -0.0175; -2.8973]; 
qmax = [2.8973; 1.7628; 2.8973; -0.0698; 2.8973; 3.7525; 2.8973];

% Function that gives the transformation from <base> to <e-e>, given a
% configuration of the manipulator
bTe = getTransform(model.franka,[q_init',0,0],'panda_link7');%DO NOT EDIT 

%% CHOOSE TASK
tool = true;

%% Tool frame definition
  eOt = [0, 0, 21.04]' * 0.01; % given in cm, thats why 0.01 % Orientation t wrt e
  phi = deg2rad(-44.98);
  eRt = [cos(phi), -sin(phi), 0; sin(phi), cos(phi), 0; 0, 0, 1];             
  eTt(1:3, 1:3) = eRt;
  eTt(1:3, 4) = eOt;
  eTt(4,4) = 1;

%% Goal definition 
if tool == true
    % Ex 3
    bOgt = [0.55, -0.3, 0.2]';             %[m] % Goal position
    bTt = bTe * eTt;                       % Base to Tool frame
    bRg = bTt(1:3, 1:3) * RotY(pi/6);      % Rotation around y-axisof the robot tool frame initial configuration

else
    % Ex 2 
    bOge = [0.55, -0.3, 0.2]';               %[m] % Goal position
    bRg = bTe(1:3, 1:3) * RotY(pi/6);      % Rotation around y-axis of the robot's end effector 

end

%% Switch between the two cases (with and without the tool frame)
if tool == true
    % Ex 3 
    bTg(1:3,4) = bOgt; % if controlling the tool frame
    bTg(1:3,1:3) = bRg;
    bTg(4,4) = 1;
else
    % Ex 2
    bTg(1:3,4) = bOge; %if controlling the ee frame
    bTg(1:3,1:3) = bRg;
    bTg(4,4) = 1;
end


% Control Proportional Gain 
angular_gain = 0.2;
linear_gain = 0.2;

% Preallocation variables
x_dot = zeros(6,1);
lin_err = zeros(3,1);
ang_err = zeros(3,1); 

% Start the inverse kinematic control  
q = q_init;

%% Simulation Loop
for i = t
    clf;
    %% Cartesian error to reach the goal
    if tool == true %compute the error between the tool frame and goal frame
        
        % Computing transformation matrix from base to end effector 
        bTe = getTransform(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
        tmp = geometricJacobian(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
        bJe = tmp(1:6,1:7); %DO NOT EDIT

        bTt = bTe * eTt; % Update tool frame
        
        [lin_err, theta, v] = ComputeError(bTt,bTg);
        rho = bTe(1:3,1:3) * (theta*v);
        ang_err = rho;
       

        % Rigid body Jacobian
        r = [0 -bTt(3,4), bTt(2,4);
             bTt(3,4) 0 -bTt(1,4);
             -bTt(2,4), bTt(1,4), 0];
        S = [eye(3), zeros(3); r, eye(3)];
        bJt = S * bJe;
        
    else % compute the error between the e-e frame and goal frame
        % Computing transformation matrix from base to end effector 
        bTe = getTransform(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
        % Computing end effector jacobian w.r.t. base
        tmp = geometricJacobian(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
        bJe = tmp(1:6,1:7); %DO NOT EDIT
        
        [lin_err, theta, v] = ComputeError(bTe,bTg);
        ang_err = bTe(1:3,1:3) * (theta * v);
    end
    
    err = [ang_err; lin_err];

    
       
    %% Compute the reference velocities
    big_lambda = [ angular_gain * eye(3), zeros(3,3);
                    zeros(3,3), linear_gain * eye(3)];
   
    x_dot = big_lambda * err; % Goal velocity is zero 
   
    %% Compute desired joint velocities 
    if tool == true
       q_dot = pinv(bJt) * x_dot;
    else
        q_dot = pinv(bJe) * x_dot;
    end

    %% Simulate the robot - implement the function KinematicSimulation()
    q = KinematicSimulation(q(1:7), q_dot,ts, qmin, qmax);
    % DO NOT EDIT - plot the robot moving
    %switch visuals to off for seeing only the frames
    show(model.franka,[q',0,0],'visuals','on');
    hold on
    if tool == true
        %set the window size of the figure to "full-screen" for a better visualization
        plot3(bTt(1,4),bTt(2,4),bTt(3,4),'go','LineWidth',15);
        plot3(bOgt(1),bOgt(2),bOgt(3),'ro','LineWidth',5);
    else
        plot3(bTe(1,4),bTe(2,4),bTe(3,4),'go','LineWidth',15);
        plot3(bOge(1),bOge(2),bOge(3),'ro','LineWidth',5);
    end
    drawnow    
    if(norm(x_dot) < 0.001)
        disp('REACHED THE REQUESTED GOAL POSITION')
        break
    end
end
