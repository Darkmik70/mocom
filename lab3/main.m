%% Modelling and Control of Manipulator assignment 3: Inverse Kinematic Control

model = load('include/panda.mat');%load the Franka Panda robot model
ts = 0.5;
t_start = 0.0;
t_end = 30.0;
t = t_start:ts:t_end;

% joint limits
q_init = [0.0167305,-0.762614,-0.0207622,-2.34352,-0.0305686,1.53975,0.753872]';%robot home configuration
qmin = [-2.8973;-1.7628;-2.8973;-3.0718;-2.8973;-0.0175;-2.8973];
qmax = [2.8973;1.7628;2.8973;-0.0698;2.8973;3.7525;2.8973];
bTe = getTransform(model.franka,[q',0,0],'panda_link7'); %useful for save initial end-effector orientation w.r.t robot base
% goal definition 
goal_XYZ = [0.6; 0.4; 0.4];
bTg = [bTe(1:3,1:3)*rotation(0,0,-pi/4) goal_XYZ;0 0 0 1];
% control proportional gain 
angular_gain = 0.2;
linear_gain = 0.2;
% preallocation variables
x_dot = zeros(6,1);
error_linear = zeros(3,1);
error_angular = zeros(3,1); 
% Start the inverse kinematic control 
q = q_init;
for i = t
    % computing transformation matrix from base to end effector 
    bTe = getTransform(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
    % computing end effector jacobian 
    tmp = geometricJacobian(model.franka,[q',0,0],'panda_link7'); %DO NOT EDIT
    bJe = tmp(1:6,1:7);
    error_linear = bTg(1:3,4) - bTe(1:3,4); 
    error_angular = VersorLemma(bTe(1:3,1:3), bTg(1:3,1:3));
    
    % computing the end effector desired velocity 
    x_dot(1:3) = angular_gain*(error_angular);
    x_dot(4:6) = linear_gain*(error_linear);
    % computing q_dot 
    q_dot = pinv(bJe)*x_dot;
    % simulating the robot
    q = KinematicSimulation(q(1:7), q_dot,ts, qmin, qmax);
    
    show(model.franka,[q',0,0],'visuals','on');%switch visuals to off for seeing only the frames
    drawnow
    if(norm(x_dot) < 0.01)
        disp('REACHED THE REQUESTED GOAL POSITION')
        break
    end
end
