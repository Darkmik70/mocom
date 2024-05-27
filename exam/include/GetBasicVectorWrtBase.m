function r = GetBasicVectorWrtBase(biTei, linkNumber)
%%% GetBasicVectorWrtBase function
% Input :
% iTj trasnformation matrix in between i and j

% Output
% r : basic vector from i to j

% Calculate Transformation Matrix
bTi = GetTransformationWrtBase(biTei, linkNumber);

% Extract the first three elements from last column
r = bTi(1:3,4);
end

