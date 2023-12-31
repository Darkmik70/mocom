function [Rot] = RotY(theta)
%Calculate 3D rotation about Y axis

Rot = [cos(theta)   0   sin(theta);
       0    1   0;
       -sin(theta)  0   cos(theta)];
end

