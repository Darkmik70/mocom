% Author Michal Krepa 6475383
function [q] = KinematicSimulation(q, q_dot, ts, q_min, q_max)
%% Kinematic Simulation function
%
% Inputs
% - q current robot configuration
% - q_dot joints velocity
% - ts sample time
% - q_min lower joints bound
% - q_max upper joints bound
%
% Outputs
% - q new joint configuration

% Updating q
q = q + q_dot * ts;

% Saturating the joint velocities 
for i = 1 : 8

    if q(i) < q_min(i)
        q(i) = q_min(i);
    
    elseif q(i) > q_max(i)
        q(i) = q_max(i);
    end

end

end