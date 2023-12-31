clc; clear; close all;
addpath('include');
%% Modelling and Control of Manipulator assignment 3 - Exercise 1: Jacobian matrix

% The same model of assignment 2
geom_model = BuildTree(); % literally the same model from lab 2 
numberOfLinks = size(geom_model,3); % number of manipulator's links.
linkType = zeros(numberOfLinks,1); % specify two possible link type: Rotational, Prismatic.
bTi = zeros(4,4,numberOfLinks);% Trasformation matrix i-th link w.r.t. base


% change the unit from [mm] to [m]
geom_model = geom_model;


% Initial joint configurations 
% q0 = [1.3,1.3,1.3,1.3,1.3,1.3,1.3]; 
q1 = [1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 1.8];
q2 = [ 0.3, 1.4, 0.1, 2.0, 0, 1.3, 0];
q3 = [ 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0];
q4 = [1,1,1,1,1,1,1];


%% Compute direct geometry
q1 = [1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 1.8];
biTei = GetDirectGeometry(q1, geom_model, linkType);
J1 = GetJacobian(biTei, linkType)


q2 = [ 0.3, 1.4, 0.1, 2.0, 0, 1.3, 0];
biTei = GetDirectGeometry(q2, geom_model, linkType);
J2 = GetJacobian(biTei, linkType)

q3 = [ 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0];
biTei = GetDirectGeometry(q3, geom_model, linkType);
J3 = GetJacobian(biTei, linkType)


q4 = [1, 1, 1, 1, 1, 1, 1];
biTei = GetDirectGeometry(q4, geom_model, linkType);
J4 = GetJacobian(biTei, linkType)
