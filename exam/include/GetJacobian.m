function J = GetJacobian(biTei, linkType)
%% GetJacobian function
% Function returning the end effector jacobian for a manipulator which current
% configuration is described by bTei.
%
% Inputs:
% - biTei: vector of matrices containing the transformation matrices from
% joint i-1 to joint i for the current configuration.
% - bTe: current transformation matrix from base to the end effector.
% - linkType: vector identifying the joint type, 0 for revolute, 1 for
% prismatic
%
% Output:
% - J: end-effector jacobian matrix
numberOfLinks = size(linkType,1);


% get the vector of matrices of Transformation of every joint wrt base
for i = 1 : numberOfLinks
    bTi_q(:,:,i) = GetTransformationWrtBase(biTei, i);
end 

% Extract the transformation matrix, bTe, of the end-effector w.r.t. the
% base from bTi_q
bTe = bTi_q(:, :, numberOfLinks);

% Extract vector bre linking the base to the end-effector from bTe
bre = bTe(1:3,4);

% Define the 3xn Jacobian matrix
J = zeros(6, numberOfLinks);

% For every transformation in bTi_q, we fill one collumn
for i = 1:numberOfLinks
    
    % Extract the transformation matrix, bTi, of link <i> w.r.t. the base
    bTi = bTi_q(:,:,i);

    % Extract the unit vector in the z-direction, bKi, from the rotational component
    % of each transformation bTi and assign it to the angular component of the Jacobian
    Jw = bTi(1:3,3);
    
    % Compute the cross product of bKi and bri and assign it to the linear
    % component of the Jacobian
    ire = bre - bTi(1:3,4);
    Jv = cross(bTi(1:3,3),ire);

    % % Change unit from mm to m
    % Jv = Jv * 0.001;

    h = [Jw; Jv];
    J(:,i) = h;
end

end
