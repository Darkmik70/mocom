function [rot_x] = rot_x(theta)
   rot_x = [1 0 0; 0 cos(theta) -sin(theta); 0 sin(theta) cos(theta)];
end

