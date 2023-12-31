%% Exercises Modelling Part 1
clc; clear;
close all; % closes all the figures
% Rotation matrices, Equivalent angle-axis representations, Quaternions
addpath('include') %%DO NOT CHANGE STUFF INSIDE THIS PATH

%% Exercise 1
% Write a function called ComputeAngleAxis() implementing the Rodrigues Formula,
% taking in input the geometric unit vector v and the rotation angle theta
% and returning the orientation matrix.
% and test it for the following cases:


%% Test
theta = 0; v = [0,0,0];
aRb = ComputeAngleAxis(theta, v);
disp('aRb ex 1.1:');disp(aRb);
plotRotation(theta,v,aRb);

%% 1.1.

theta = 0; v = [0,0,0];
aRb = ComputeAngleAxis(theta, v);
disp('aRb ex 1.1:');disp(aRb);
plotRotation(theta,v,aRb);


%% 1.2.
theta = pi/4; v = [1,0,0];
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.2:');disp(aRb);
disp('theta ex 1.2:');disp(theta);
disp('v ex 1.2:');disp(v);

%% 1.3.
theta = pi/6; v = [0,1,0];
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.3:');disp(aRb);
disp('theta ex 1.3:');disp(theta);
disp('v ex 1.3:');disp(v);

%% 1.4.
theta = 3*pi/4; v = [0,0,1];
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.4:');disp(aRb);
disp('theta ex 1.4:');disp(theta);
disp('v ex 1.4:');disp(v);


%% 1.5.
theta = 2.8; v = [0.3202, 0.5337, 0.7827];
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.5:');disp(aRb);
disp('theta ex 1.5:');disp(theta);
disp('v ex 1.5:');disp(v);


%% 1.6.
rho = [0 2*pi/3 0]; %knowing that rho = v * theta
theta = norm(rho); v = rho/theta;
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.6:');disp(aRb);
disp('theta ex 1.6:');disp(theta);
disp('v ex 1.6:');disp(v);


%% 1.7.
rho = [0.25, -1.3, 0.15]; %knowing that rho = v * theta
theta = norm(rho); v = rho/theta;
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.7:');disp(aRb);
disp('theta ex 1.7:');disp(theta);
disp('v ex 1.7:');disp(v);


%% 1.8.
rho = [-pi/4, -pi/3 ,pi/6];
theta = norm(rho); v = rho/theta;
aRb = ComputeAngleAxis(theta, v);
plotRotation(theta,v,aRb);
disp('aRb ex 1.8:');disp(aRb);
disp('theta ex 1.8:');disp(theta);
disp('v ex 1.8:');disp(v);


%% Exercise 2
% 2.1. Write the relative rotation matrix aRb
% 2.2. Solve the Inverse Equivalent Angle-Axis Problem for the orientation matrix aRb.

% 2.3. Repeat the exercises using the wRc instead of wRa (more general example)
% NB: check the notation used !

% 2.1
% Initialize the rotation matrices, using the suggested notation

%rotation matrix from <w> to frame <a>
wRa = eye(3);

%rotation matrix from <w> to <b> (represent 90° around z)
alpha = pi/2;
rot_z = [cos(alpha) -sin(alpha) 0; ...
    sin(alpha) cos(alpha) 0;  ...
    0 0 1]; % rotation around z
wRb = eye(3) * rot_z;



% Compute the rotation matrix between frame <a> and <b>

aRb = wRa' * wRb;

%%

% 2.2
% Compute the inverse equivalent angle-axis repr. of aRb
[theta, v] = ComputeInverseAngleAxis(aRb);
% Plot Results
disp('aRb ex 2.1:');disp(aRb);
plotRotation(theta,v,aRb);
disp('theta ex 2.2:');disp(theta);
disp('v ex 2.2:');disp(v);

%% 2.3

wTc = [0.835959 -0.283542 -0.46986 0; 0.271321 0.957764 -0.0952472 -1.23; ...
    0.47703 -0.0478627 0.877583 14; 0 0 0 1];

% Compute the rotation matrix between frame <c> and <b>
wRc = wTc(1:3, 1:3);
cRb = wRb'*wRc;
% Compute inverse equivalent angle-axis repr. of cRb
[theta, v] = ComputeInverseAngleAxis(cRb);
% Plot Results
plotRotation(theta,v,cRb);
disp('theta ex 2.3:');disp(theta);
disp('v ex 2.3:');disp(v);
new_R = ComputeAngleAxis(theta,v);
plotRotation(theta,v,new_R);
disp('theta ex 2.3:');disp(theta);
disp('v ex 2.3:');disp(v);

%% Exercise 3
% 3.1 Given two generic frames < w > and < b >, define the elementary
% orientation matrices for frame < b > with respect to frame < w >, knowing
% that:
% a. < b > is rotated of 45◦ around the z-axis of < w >
% b. < b > is rotated of 60◦ around the y-axis of < w >
% c. < b > is rotated of -30◦ around the x-axis of < w >
% 3.2 Compute the equivalent angle-axis representation for each elementary rotation
% 3.3 Compute the z-y-x (yaw,pitch,roll) representation using the already
% computed matrices and solve the Inverse Equivalent Angle-Axis Problem
% 3.4 Compute the z-x-z representation using the already computed matrices
% and solve the Inverse Equivalent Angle-Axis Problem

% 3.1
% hint: define angle of rotation in the initialization

% a
%rotation matrix from <w> to frame <b> by rotating around z-axes by
%45° represented in radians
v=[0,0,1];
theta = pi/4;
wRb_z = [cos(theta) -sin(theta) 0;
    sin(theta) cos(theta) 0;
    0 0 1] ;

% b
%rotation matrix from <w> to frame <b> by rotating around y-axes by
%60° represented in radians
v=[0,1,0];
theta = pi/3;
wRb_y = [cos(theta) 0 sin(theta);
    0 1 0;
    -sin(theta) 0 cos(theta)] ;

% c
%rotation matrix from <w> to frame <b> by rotating around x-axes by
%-30° represented in radians
v=[1,0,0];
theta = -pi/6;
wRb_x = [1 0 0; 0 cos(theta) -sin(theta);0    sin(theta) cos(theta);
    0 0 1] ;
disp('es 3.1:');disp(wRb_z);disp(wRb_y);disp(wRb_x);

%% 3.2
% a
[theta, v] = ComputeInverseAngleAxis(wRb_z);
% Plot Results
plotRotation(theta,v,wRb_z);
disp('theta ex 3.2.a:');disp(theta);
disp('v ex 3.2.a:');disp(v);
% b
[theta, v] = ComputeInverseAngleAxis(wRb_y);
% Plot Results
 plotRotation(theta,v,wRb_y);
disp('theta ex 3.2.b:');disp(theta);
disp('v ex 3.2.b:');disp(v);
% c
[theta, v] = ComputeInverseAngleAxis(wRb_x);
% Plot Results
plotRotation(theta,v,wRb_x);
disp('theta ex 3.2.c:');disp(theta);
disp('v ex 3.2.c:');disp(v);
% 3.3
% Compute the rotation matrix corresponding to the z-y-x representation;
Rzyx = wRb_z* wRb_y* wRb_x;
% Compute equivalent angle-axis repr.
[theta, v] = ComputeInverseAngleAxis(Rzyx);
% Plot Results
plotRotation(theta,v,Rzyx);
disp('theta ex 3.3:');disp(theta);
disp('v ex 3.3:');disp(v);


% 3.4
% Compute the rotation matrix corresponding to the z-x-z representation;
Rzxz = wRb_z* wRb_x* wRb_z;   %still waiting for confimration on
% whether we can represent like this

% Compute equivalent angle-axis repr.
[theta, v] = ComputeInverseAngleAxis(Rzxz);
% Plot Results
plotRotation(theta,v,Rzxz);
disp('theta ex 3.4:');disp(theta);
disp('v ex 3.4:');disp(v);


%% Exercise 4
% 4.1 Represent the following quaternion with the equivalent angle-axis
% representation. q = 0.1647 + 0.31583i + 0.52639j + 0.77204k
% 4.2 Solve the Inverse Equivalent Angle-Axis Problem for the obtained
% orientation matrix
% 4.3 Repeat the exercise using the built-in matlab functions see:
% https://it.mathworks.com/help/nav/referencelist.html?type=function&category=coordinate-system-transformations&s_tid=CRUX_topnav
% CHECK IF THE RESULT IS THE SAME

% 4.1 Compute the rotation matrix associated with the given quaternion
q0 = 0.1647;
q1 = 0.315831;
q2 = 0.52639;
q3 = 0.77204;
rotMatrix = quatToRot(q0,q1,q2,q3);

% Evaluate angle-axis representation and display rotations
[theta, v] = ComputeInverseAngleAxis(rotMatrix);
% Plot Results
plotRotation(theta,v,rotMatrix);
disp('rot matrix ex 4.1');disp(rotMatrix)

%4.3. solve using matlab functions quaternion(), rotmat(),
quat = [q0 q1 q2 q3];
rotMatrix_matlab = quat2rotm(quat);

% Evaluate angle-axis representation and display rotations - check if the
% same results as before
[theta, v] = ComputeInverseAngleAxis(rotMatrix_matlab);
% Plot Results
plotRotation(theta,v,rotMatrix_matlab);
disp('matrix from builtin functions ex 4.3');disp(rotMatrix_matlab)