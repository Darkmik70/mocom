function [s, rho] = ComputeError(bTe,bTg)
%GetError function, computes error between two transformation matrices
% bTe:  transformation matrix that describes the current position of the
%         end-eff w.r.t. the base;
% bTg:  goal transformation matrix w.r.t. the base;outputArg1 = inputArg1;
    
    % obtain the position vectors
    r_be = bTe(1:3, 4);
    r_bg = bTg(1:3, 4);

    % obtain the rotational matrices
    bRe = bTe(1:3, 1:3);
    bRg = bTg(1:3, 1:3);

    % Distance zeroing
    s = r_bg - r_be;    

    % Misalignment zeroing
    eRg = inv(bTe(1:3,1:3) * bTg(1:3,1:3));
    [theta, v] = ComputeInverseAngleAxis(eRg);
    rho = theta * v;
end