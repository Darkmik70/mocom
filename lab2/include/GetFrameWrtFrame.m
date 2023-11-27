function [iTj]=GetFrameWrtFrame(biTei, linkNumber_i, linkNumber_j)
%%% GetFrameWrtFrame function 
% inputs : 
% linkNumber_i : number of ith link 
% linkNumber_j: number of jth link 
% biTei vector of matrices containing the transformation matrices from link i to link i +1 for the current q.
% The size of biTei is equal to (4,4,numberOfLinks)
% outputs:
% iTj : transformationMatrix in between link i and link j for the
% configuration described in biTei

% Allocate memory for Transformation matrix
iTj = eye(4);

if linkNumber_i <= linkNumber_j
    % Calculate transformation from i to j frames
    for i = linkNumber_i : linkNumber_j
        iTj = iTj * biTei(:,:,i)
    end
elseif linkNumber_i > linkNumber_j
    % Transformation goes in reverse
    for i = linkNumber_j : linkNumber_i
        iTj = biTei(:,:,i) * iTj;
    end
else
    error('Link numbers are wrong');
end

end

