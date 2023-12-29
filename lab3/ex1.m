clc; clear; close all;
addpath('include');
%% Modelling and Control of Manipulator assignment 3 - Exercise 1: Jacobian matrix

% The same model of assignment 2
geom_model = BuildTree(); % literally the same model
numberOfLinks = size(geom_model,3); % number of manipulator's links.
linkType = zeros(numberOfLinks,1); % specify two possible link type: Rotational, Prismatic.
bTi = zeros(4,4,numberOfLinks);% Trasformation matrix i-th link w.r.t. base

% Initial joint configurations 
% q0 = [1.3,1.3,1.3,1.3,1.3,1.3,1.3];
q1 = [1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 1.8];
q2 = [ 0.3, 1.4, 0.1, 2.0, 0, 1.3, 0];
q3 = [ 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6];
q4 = [1,1,1,1,1,1,1];

q = [q1; q2; q3; q4];

%% Compute direct geometry

for i = 1 : size(q, 1)
    % Direct Geometry
    biTei = GetDirectGeometry(q(i,:), geom_model, linkType);
    % Transformation wrt base
    bTe = GetTransformationWrtBase(biTei, linkType);
    % EE Jacobian matrix
    J(:,:,i) = GetJacobian(biTei, bTe, linkType);
end

