function [rot_z] = rot_z(theta)
    rot_z = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
end

