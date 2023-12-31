function [iTj_q] = GetDirectGeometry(q, iTj, linkType)
%%% GetDirectGeometryFunction

% Inputs:
% q : links current position ;
% iTj : vector of matrices containing the transformation matrices from
% joint i to joint j
% JointType: vector of size numberOfLinks identiying the joint type, 0 for revolute, 1 for
% prismatic.

% Outputs :
% iTj_q vector of matrices containing the transformation matrices from joint i to joint j for the input q.
% The size of iTj is equal to (4,4,numberOfLinks)

% Allocate matrix
num_of_links = size(linkType, 1);
iTj_q = zeros(4,4,num_of_links);

for i = 1:1:num_of_links
    iTj_q(:,:,i) = DirectGeometry(q(i), iTj(:,:,i), linkType(i));
end

end