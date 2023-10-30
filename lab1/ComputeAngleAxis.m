function R = ComputeAngleAxis(theta,v)
% EXPLAIN IT 
skew = [0 -v(3) v(2); ... 
        v(3) 0 -v(1); ...
        -v(2) v(1) 0;];
R = eye(3) + skew * sin(theta) + skew^2 * (1-cos(theta));
end

