%% Modelling and Control of Manipulator assignment 2: Manipulator Geometry and Direct kinematic
clc; clear; close all;
addpath('include');
%% 1.
% You will need to define all the model matrices, and fill the so called iTj matrices inside BuildTree() function 
% Be careful to define the z-axis coinciding with the joint rotation axis,
% and such that the positive rotation is the same as showed in the CAD model you received.
geom_model = BuildTree();

for i = 1:7
    i
    geom_model(:,:,i)
end


%% 2.

% Useful initizializations
numberOfLinks = size(geom_model(),3);                                               % number of manipulator's links.
% linkType :0 for revolute, 1 for prismatic
linkType = zeros(numberOfLinks,1);                                             % boolean that specifies two possible link types: Rotational, Prismatic.
bri= zeros(3,numberOfLinks);                                                    % Basic vector of i-th link w.r.t. base
bTi = zeros(4,4,numberOfLinks);                                              % Trasformation matrix i-th link w.r.t. base

% Initial joint configuration 
q = [0,0,0,0,0,0,0];




% Q1.1 and Q1.2
iTj_q = GetDirectGeometry(q, geom_model, linkType);
%%
%Q1.3
for i =1:numberOfLinks
    bTi(:,:,i)= GetTransformationWrtBase();
end

for i= 1:length(linkNumber_i)
    iTj(:,:,i) = GetFrameWrtFrame();
end

for i = 1:numberOfLinks
    bri(:,i) = GetBasicVectorWrtBase();
end

% Q1.4
% Hint: use plot3() and line() matlab functions. 
qi = q;
qf = [];
numberOfSteps =100;

for i = 1:numberOfSteps
%-------------------MOVE----------------------%
    
end
