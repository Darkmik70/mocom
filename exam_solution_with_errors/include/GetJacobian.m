% Author Michal Krepa 6475383
function J = GetJacobian(biTei, bTe, jointType)
%% GetJacobian function
% Function returning the end effector jacobian for a manipulator which current
% configuration is described by bTei.
%
% Inputs:
% - biTei: vector of matrices containing the transformation matrices from
% joint i-1 to joint i for the current configuration.
% - bTe: current transformation matrix from base to the end effector.
% - jointType: vector identifying the joint type, 0 for revolute, 1 for
% prismatic
%
% Output:
% - J: end-effector jacobian matrix
numberOfLinks = size(jointType,2);

% Extract vector bre linking the base to the end-effector from bTe
bre = bTe(1:3,4);

% Define the 6xn Jacobian matrix
J = zeros(6, numberOfLinks);

% get the vector of matrices of Transformation of every joint wrt base
for i = 1 : numberOfLinks
    bTi_q(:,:,i) = GetTransformationWrtBase(biTei, i);
end 

% For every transformation in bTi_q, we fill one collumn
for i = 1:numberOfLinks

    % Extract the transformation matrix, bTi, of link <i> w.r.t. the base
    bTi = bTi_q(:,:,i);
    
    if jointType(i) == 0 %revolute joint

        % Extract the unit vector in the z-direction, bKi, from the rotational component
        % of each transformation bTi and assign it to the angular component of the Jacobian
        Jw = bTi(1:3,3);

        % Compute the cross product of bKi and bri and assign it to the linear
        % component of the Jacobian
        ire = bre - bTi(1:3,4);
        Jv = cross(bTi(1:3,3),ire);

    else    %prismatic joint
        Jw = [0; 0; 0];
        Jv = bTi(1:3,4);
    end

    h = [Jw; Jv];
    J(:,i) = h;
end

end
