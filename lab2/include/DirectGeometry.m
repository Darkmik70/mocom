function iTj_q = DirectGeometry(qi, iTj, linkType)
% DirectGeometry Function 
% inputs: 
% qi : current joint position;
% iTj is the constant transformation between the base of the link <i>
% and its follower frame <j>; 
% linkType :0 for revolute, 1 for prismatic

% output :
% iTj_q : transformation between the base of the joint <i> and its follower frame taking 
% into account the actual rotation/traslation of the joint

if linkType == 0 % rotational
    % in case of rotational joint we are always rotating about z-axis
    Rot(1,1) = cos(qi); Rot(1,2) = -sin(qi); Rot(1,3) = 0; Rot(1,4) = 0;
    Rot(2,1) = sin(qi); Rot(2,2) = cos(qi); Rot(2,3) = 0; Rot(2,4) = 0;
    Rot(3,1) = 0; Rot(3,2) = 0; Rot(3,3) = 0; Rot(3,4) = 0;
    Rot(4,1) = 0; Rot(4,2) = 0; Rot(4,3) = 0; Rot(4,4) = 1;

    iTj_q = iTj * Rot; 
 
elseif linkType == 1 % prismatic
    % we also assume here that translations got by z-axis
    Trans(1,1) = 0; Trans(1,2) = 0; Trans(1,3) = 0; Trans(1,4) = 0;
    Trans(2,1) = 0; Trans(2,2) = 0; Trans(2,3) = 0; Trans(2,4) = 0;
    Trans(3,1) = 0; Trans(3,2) = 0; Trans(3,3) = 0; Trans(3,4) = qi;
    Trans(4,1) = 0; Trans(4,2) = 0; Trans(4,3) = 0; Trans(4,4) = 1;

    iTj_q = iTj * Trans; 
else
    disp("Error in LinkType")
end

end