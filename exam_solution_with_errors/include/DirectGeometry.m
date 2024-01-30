% Author Michal Krepa 6475383
function iTj_qi = DirectGeometry(qi, iTj, jointType)
% DirectGeometry Function 
% inputs: 
% qi : current link position;
% iTj is the constant transformation between the base of the link <i>
% and its follower frame <j>;
% jointType :0 for revolute, 1 for prismatic

% output :
% iTj_qi : transformation between the base of the joint <i> and its follower frame taking 
% into account the actual rotation/translation of the joint qi

if jointType == 0 % rotational
    % in case of rotational joint we are always rotating about z-axis
    Rot(1,1) = cos(qi); Rot(1,2) = -sin(qi); Rot(1,3) = 0; Rot(1,4) = 0;
    Rot(2,1) = sin(qi); Rot(2,2) = cos(qi); Rot(2,3) = 0; Rot(2,4) = 0;
    Rot(3,1) = 0; Rot(3,2) = 0; Rot(3,3) = 1; Rot(3,4) = 0;
    Rot(4,1) = 0; Rot(4,2) = 0; Rot(4,3) = 0; Rot(4,4) = 1;
    
    iTj_qi = iTj * Rot;

elseif jointType == 1 % prismatic
    % we also assume here that translations go along z-axis
    Trans(1,1) = 1; Trans(1,2) = 0; Trans(1,3) = 0; Trans(1,4) = 0;
    Trans(2,1) = 0; Trans(2,2) = 1; Trans(2,3) = 0; Trans(2,4) = 0;
    Trans(3,1) = 0; Trans(3,2) = 0; Trans(3,3) = 1; Trans(3,4) = qi;
    Trans(4,1) = 0; Trans(4,2) = 0; Trans(4,3) = 0; Trans(4,4) = 1;

    iTj_qi = iTj * Trans;
    
else
    disp("Error in jointType")

end


end
