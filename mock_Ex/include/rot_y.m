function [rot_y] = rot_y(theta)
    rot_y = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
end

