function [theta,v] = ComputeInverseAngleAxis(R)
%EULER REPRESENTATION: Given a tensor rotation matrices this function
% should output the equivalent angle-axis representation values,
% respectively 'theta' (angle), 'v' (axis)
% NB: Enter a square, 3x3 proper-orthogonal matrix to calculate its angle
% and axis of rotation. Error messages must be displayed if the matrix
% does not satisfy the rotation matrix criteria.

% Check matrix R to see if its size is 3x3
if size(R) == size(eye(3))
    % Check matrix R to see if it is orthogonal
    if  isequal(int8(R*R'),eye(3))
        % Check matrix R to see if it is proper: det(R) = 1
        if int8(det(R)) == 1 %isequal(int8(det(R)), 1)
            % Compute the angle of rotation
            theta = acos((trace(R) - 1)/2);
            % Calculate eigenvalues and eigenvectors of R
            [eigenvectors, eigenvalues] = eig(R); % still have the amiguity of the sign

            % Compute the axis of rotation
            % find the index of our eigenvalue that == 1, then
            % put the eigenvectors into v_temp
            idx = find(diag(int8(eigenvalues) == 1)); 
            v_temp = eigenvectors(:,idx);

            R_pos = ComputeAngleAxis(theta,v_temp);
            R_neg = ComputeAngleAxis(-theta,v_temp);
            % Check which R corresponds to our R, here we use tolerance
            % to 1e-4 as we assume it will be enough to provide precise
            % rotation.
            tolerance = 1e-4;
            if all(abs(R - R_pos) < tolerance, "all")
                v = v_temp;
            elseif all(abs(R - R_neg) < tolerance, "all")
                v = -v_temp;
            else
                err("Calculation of R is wrong!")
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

