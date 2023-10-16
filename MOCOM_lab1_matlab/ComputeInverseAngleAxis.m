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
    
    % Check matrix R to see if its size is 3x3
    if 
        
        % Check matrix R to see if it is orthogonal
        if 
            % Check matrix R to see if it is proper: det(R) = 1
            
            if 
                % Compute the angle of rotation
                
                % Calculate eigenvalues and eigenvectors of R
                
                % Compute the axis of rotation
               

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

