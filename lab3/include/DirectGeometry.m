function biTie = DirectGeometry(qi, iTj, linkType)
% DirectGeometry Function 
% inputs: 
% q : current link position;
% biTri is the constant transformation between the base of the link <i>
% and its end-effector; 
% jointType :0 for revolute, 1 for prismatic

% output :
% biTie : transformation between the base of the joint <i> and its end-effector taking 
% into account the actual rotation/traslation of the joint

if linkType == 0 % rotational

elseif linkType == 1 % prismatic

end

end