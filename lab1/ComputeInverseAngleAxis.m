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
    if size(R) == size(eye(3))      
        % Check matrix R to see if it is orthogonal
        if  isequal(int8(R*R'), eye(3))%R*R' == eye(3) %or  
            % Check matrix R to see if it is proper: det(R) = 1
            if int8(det(R)) == 1 %isequal(int8(det(R)), 1)
                % Compute the angle of rotation
                theta = acos((trace(R) - 1)/2);
                % Calculate eigenvalues and eigenvectors of R
                [eigenvectors, eigenvalues] = eig(R); % still have the amiguity of the sign
                % Compute the axis of rotation
                for r=1:3
                    for c=1:3
                        if(int8((eigenvalues(r,c))) == 1)
                            v_temp = eigenvectors(:,c);  %                       
                        end
                    end
                end
                % check which sign corresponds to our R
                R_pos = ComputeAngleAxis(theta,v_temp);
                R_neg = ComputeAngleAxis(-theta,v_temp);
                % Explain this 
                tolerance = 1e-4;
                if all(abs(R - R_pos) < tolerance, "all")
                    v = v_temp;
                elseif all(abs(R - R_neg) < tolerance, "all")
                    v = -v_temp;
                else
                    err("Something went really wrong")
                end
              %%
              % Note that when you find eigenvectors of a matrix, you have the ambiguity of the sign. 
              % An eigenvector identifies the line, but not the direction. If v is an eigenvector, so is -v.
              % Hence, once you identify the eigenvector v with eigenvalue 1 and have theta from the arccos function, you are not done yet. 
              % You have to disambiguate the sign. The solution is to compute the corresponding R for both theta*v and -theta*v, 
              % and keep only the sign of theta that gives you the correct R.

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

