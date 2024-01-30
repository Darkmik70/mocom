% Author Michal Krepa 6475383
function [biTei] = GetDirectGeometry(q, geom_model, jointType)
%%% GetDirectGeometryFunction

% Inputs: 
% q : links current position ; 
% geom_model : vector of matrices containing the transformation matrices from link
% i to link j
% jointType: vector of size numberOfLinks identiying the joint type, 0 for revolute, 1 for
% prismatic.

% Outputs :
% biTei vector of matrices containing the transformation matrices 
% from link i to link j for the input q. 
% The size of geom_model is equal to (4,4,numberOfLinks)

% Allocate matrix
num_of_links = size(jointType, 2);
biTei = zeros(4,4,num_of_links);

for i = 1:1:num_of_links
    biTei(:,:,i) = DirectGeometry(q(i), geom_model(:,:,i), jointType(i));
end


end