%% Modelling and Control of Manipulator assignment 2: Manipulator Geometry and Direct kinematic
clc; clear; close all;
addpath('include');
%% Q1.2
% You will need to define all the model matrices, and fill the so called iTj matrices inside BuildTree() function 
% Be careful to define the z-axis coinciding with the joint rotation axis,
% and such that the positive rotation is the same as showed in the CAD model you received.
geom_model = BuildTree();

% Useful initizializations
numberOfLinks = size(geom_model(),3);% number of manipulator's links.
% linkType :0 for revolute, 1 for prismatic ALL OF OUR LINKS ARE R
linkType = zeros(numberOfLinks,1);     % boolean that specifies two possible link types: Rotational, Prismatic.
bri= zeros(3,numberOfLinks);           % Basic vector of i-th link w.r.t. base
bTi = zeros(4,4,numberOfLinks);       % Trasformation matrix i-th link w.r.t. base
% iTj = zeros(4,4,numberOfLinks);       % Transformation matrix from i-th to j-th link


for i = 1 : numberOfLinks
    i;
     geom_model(:,:,i);
end

%% Q1.2
                                       
% Initial joint configuration 
% 1
q1 = [0, 0, 0, 0, 0, 0, 0];
iTj_q1 = GetDirectGeometry(q1, geom_model, linkType);

% 2 
q2 = [0, 0, 0, 0, 0, pi/2, 0];
iTj_q2 = GetDirectGeometry(q2, geom_model, linkType);

% 3
q3 = [0, pi/2, 0, -pi/2, 0, 0, 0];
iTj_q3 = GetDirectGeometry(q3, geom_model, linkType);


% 4
q4 = [pi/4, pi/2, -pi/8, -pi/2, pi/4, 2/(3*pi), 0];
iTj_q4 = GetDirectGeometry(q4, geom_model, linkType);

%% Q1.3

% Calculate Transformation between all links in respect to the base
for i =1:numberOfLinks
    bTi(:,:,i)= GetTransformationWrtBase(geom_model, i);
end

% Get Coressponding vectors 
for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase(geom_model, i)
end

% Get Transformation for any two links
a = 3;
b = 5;
iTj = GetFrameWrtFrame(geom_model, a, b);

%% Q1.4
% 1
q_i_1 = [0, 0, 0, 0, 0, 0, 0];
q_f_1 = [pi/4, pi/2, -pi/8, -pi/2, pi/4, 2/(3*pi), 0];
fig1 = PlotConfiguration(q_i_1, q_f_1, geom_model,linkType);

% 2
q_i_2 = [0, pi/2, 0, -pi/2, 0, 0, 0];
q_f_2 = [0, 0, 0, 0, 0, 0, 0];
fig2 = PlotConfiguration(q_i_2, q_f_2, geom_model,linkType);

% 3
q_i_3 = [1.3, 0.1, 0.1, 1, 0.2, 0.3, 1.3]; % Those are radians, boys
q_f_3 = [2, 2, 2, 2, 2, 2, 2];
fig2 = PlotConfiguration(q_i_2, q_f_2, geom_model,linkType);


%% 
% Hint: use plot3() and line() matlab functions.
% Initial joint configuration 
% 1




%%

for i = 1:numberOfSteps
%-------------------MOVE----------------------%
    
end
