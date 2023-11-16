function iTj_q = DirectGeometry(qi, iTj, linkType)
% DirectGeometry Function 
% inputs: 
% qi : current joint position;
% iTj is the constant transformation between the base of the link <i>
% and its follower frame <j>; 
% jointType :0 for revolute, 1 for prismatic

% output :
% iTj_q : transformation between the base of the joint <i> and its follower frame taking 
% into account the actual rotation/traslation of the joint

if linkType == 0 % rotational

elseif linkType == 1 % prismatic

end

end