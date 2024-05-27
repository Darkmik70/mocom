function [theta,v] = ComputeInverseAngleAxis(R)
%EULER REPRESENTATION: Given a tensor rotation matrices this function
% should output the equivalent angle-axis representation values,
% respectively 'theta' (angle), 'v' (axis)
% SUGGESTED FUNCTIONS
% size()
% eye()
% eig()
% find()
% abs()
% det()
% NB: Enter a square, 3x3 proper-orthogonal matrix to calculate its angle
% and axis of rotation. Error messages must be displayed if the matrix
% does not satisfy the rotation matrix criteria.

threshold = 1e-3;

if isequal(size(R),[3 3])
    % Check matrix R to see if it is orthogonal
    if abs((R*R') - eye(3)) < threshold
        % Check matrix R to see if det(R) = 1
        if abs(det(R) - 1) < threshold
            % Compute the angle of rotation
            theta = acos((trace(R)-1)/2);
            % Calculate eigenvalues and eigenvectors of R
            [eigenvector, eigenvalue] = eig(R);
            % Compute the axis of rotation
            for i = 1:3
                for j = 1:3
                    if i == j
                        if abs(eigenvalue(i,j) - (1+0i)) < ((threshold)+(threshold * 1i))
                            v = eigenvector(:,j);
                        end
                    end
                end
            end
            % Identify the correct direction of the eigenvector
            if abs(ComputeAngleAxis(-theta,v) - R) < threshold
                theta = -theta;
            end
        else
            err('DETERMINANT OF THE INPUT MATRIX IS NOT 1')
        end
    else
        err('NOT ORTHOGONAL INPUT MATRIX')
    end
else
    err('WRONG SIZE OF THE INPUT MATRIX')
end
end

