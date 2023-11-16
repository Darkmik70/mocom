function [iTj] = BuildTree()
% This function should build the tree of frames for the chosen manipulator.
% Inputs: 'None'
% Outputs: The tree of frames.

% iTj is a 3-dimensional matlab matrix, suitable for defining tree of
% frames. iTj should represent the transformation matrix between the i-th and j-th
% frames. iTj(row,col,link_idx)

% link 1
% transformation from <0> to <1> 
% Translation in z 175
% no rotation
dz_1 = 175;

iTj(1,1,1) = 1; iTj(1,2,1) = 0; iTj(1,3,1) = 0; iTj(1,4,1) = 0;
iTj(2,1,1) = 0; iTj(2,2,1) = 1; iTj(2,3,1) = 0; iTj(2,4,1) = 0;
iTj(3,1,1) = 0; iTj(3,2,1) = 0; iTj(3,3,1) = 1; iTj(3,4,1) = dz_1;
iTj(4,1,1) = 0; iTj(4,2,1) = 0; iTj(4,3,1) = 0; iTj(4,4,1) = 1;


% link 2
% transformation from <1> to <2> 
% Translation dz_2
% rotation over x of -pi/2
dz_2 = 213 - (175 - 60);

iTj(1,1,2) = 1; iTj(1,2,2) = 0; iTj(1,3,2) = 0; iTj(1,4,2) = 0;
iTj(2,1,2) = 0; iTj(2,2,2) = 0; iTj(2,3,2) = 1; iTj(2,4,2) = 0;
iTj(3,1,2) = 0; iTj(3,2,2) = -1; iTj(3,3,2) = 0; iTj(3,4,2) = dz_2;
iTj(4,1,2) = 0; iTj(4,2,2) = 0; iTj(4,3,2) = 0; iTj(4,4,2) = 0;


% link 3
% transformation from <2> to <3>
% rotation over y of -pi/2
% translation in x
dx_3 = -(431.50 - 326.5); 

iTj(1,1,3) = 0; iTj(1,2,3) = 0; iTj(1,3,3) = -1; iTj(1,4,3) = dx_3;
iTj(2,1,3) = 0; iTj(2,2,3) = 1; iTj(2,3,3) = 0; iTj(2,4,3) = 0;
iTj(3,1,3) = 1; iTj(3,2,3) = 0; iTj(3,3,3) = 0; iTj(3,4,3) = 0;
iTj(4,1,3) = 0; iTj(4,2,3) = 0; iTj(4,3,3) = 0; iTj(4,4,3) = 1;


% link 4
% transformation from <3> to <4>
% rotation over y of pi/2
% translation in z and y
dy_4 = - 145.5;
dz_4 = 326.5;

iTj(1,1,4) = 0; iTj(1,2,4) = 0; iTj(1,3,4) = 1; iTj(1,4,4) = 0;
iTj(2,1,4) = 0; iTj(2,2,4) = 1; iTj(2,3,4) = 0; iTj(2,4,4) = dy_4;
iTj(3,1,4) = -1; iTj(3,2,4) = 0; iTj(3,3,4) = 0; iTj(3,4,4) = dz_4;
iTj(4,1,4) = 0; iTj(4,2,4) = 0; iTj(4,3,4) = 0; iTj(4,4,4) = 1;


% link 5
% transformation from <4> to <5>
% rotation over y of pi/2
% translation in x
dx_5 = 35;

iTj(1,1,5) = 0; iTj(1,2,5) = 0; iTj(1,3,5) = 1; iTj(1,4,5) = dx_5;
iTj(2,1,5) = 0; iTj(2,2,5) = 1; iTj(2,3,5) = 0; iTj(2,4,5) = 0;
iTj(3,1,5) = -1; iTj(3,2,5) = 0; iTj(3,3,5) = 0; iTj(3,4,5) = 0;
iTj(4,1,5) = 0; iTj(4,2,5) = 0; iTj(4,3,5) = 0; iTj(4,4,5) = 1;


% link 6
% transformation from <5> to <6>
% rotation over y of -pi/2
% translation in z
dz_6 = 420 - 35;

iTj(1,1,6) = 0; iTj(1,2,6) = 0; iTj(1,3,6) = -1; iTj(1,4,6) = 0;
iTj(2,1,6) = 0; iTj(2,2,6) = 1; iTj(2,3,6) = 0; iTj(2,4,6) = 0;
iTj(3,1,6) = 1; iTj(3,2,6) = 0; iTj(3,3,6) = 0; iTj(3,4,6) = dz_6;
iTj(4,1,6) = 0; iTj(4,2,6) = 0; iTj(4,3,6) = 0; iTj(4,4,6) = 1;

% link 7
% transformation from <6> to <7>
% rotation over y of pi/2
% translation in x
dx_7 = 153; % This was set during the class.

iTj(1,1,7) = 0; iTj(1,2,7) = 0; iTj(1,3,7) = 1; iTj(1,4,7) = dx_7;
iTj(2,1,7) = 0; iTj(2,2,7) = 1; iTj(2,3,7) = 0; iTj(2,4,7) = 0;
iTj(3,1,7) = -1; iTj(3,2,7) = 0; iTj(3,3,7) = 0; iTj(3,4,7) = 0;
iTj(4,1,7) = 0; iTj(4,2,7) = 0; iTj(4,3,7) = 0; iTj(4,4,7) = 1;
end