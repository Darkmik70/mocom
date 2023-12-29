function J = GetJacobian(biTei, bTe, linkType)
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

% Size of Jacobian 6 x n
n = size(linkType, 1);
% Allocate the Jacobian
J = zeros(6, n);

for i = 1 : n
    % Transformatrion matrix for the ith-joint w.r.t.
    % the base of the manipulator
    bTi = GetTransformationWrtBase(biTei, i);

    %% Fill the Jacobian columns
    % Allocate the i-th column of the Jacobian
    h = zeros(6, 1); %#ok<PREALL>

    % Unit vector that indicates the direction of the i-th joint's axis,
    ki = bTi(1:3, 3);

    % Compute the distance vector between the ee and i-th joint
    r_e0= bTe(1:3, 4);      % pos of ee w.r.t. the base
    r_i0= bTi(1:3, 4);      % pos of <i> w.r.t. the base
    r_ei= r_e0 - r_i0;      % dist between ee and <i>

    if(linkType == 0)
        % revolute joint
        h = [ki ; cross(ki, r_ei)];
    elseif (linkType == 1)
        % prismatic joint
        h = [0 ; 0 ; 0 ; ki];
    else
        error('Unrecognized link type.'); % should never reach
    end

    % Fill the Jacobian Collumn
    J(:,i) = h;
end