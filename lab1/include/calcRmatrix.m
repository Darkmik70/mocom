function [t1, t2, t3, Rmat] = calcRmatrix(theta, Raxis, p1, p2, p3, steps)

    %%%%%%%%% DO NOT CHANGE - OUT OF THE SCOPE OF THE ASSIGNMENT %%%%%%%%%%

    %Use Euler's representation to calculate the rotation matrix Rmat that
    %rotates {p1, p2, p3} to {t1, t2, t3} through an angle phi about the 
    %axis Raxis.
    
    %ti = Rmat(phi, Raxis) * pi
    
    %If steps is specified, break down the rotation into a rotation sequence
    %for animation purposes.

    %If steps is not specified, assume steps = 1.
    
    %{pi} = initial basis vector
    %{ti} = transformed {pi}
    %axis = 3x1 array of the axis of rotation
    %angle = angle in radian

    if ~exist('steps', 'var')
        steps = 1;
    end
    
    ANGLE = linspace(0,theta,steps);

    Rmat = [];
    t1 = [];
    t2 = [];
    t3 = [];
    Rsym1 = [1-Raxis(1)^2 -Raxis(1)*Raxis(2) -Raxis(1)*Raxis(3); -Raxis(2)*Raxis(1) 1-Raxis(2)^2 -Raxis(2)*Raxis(3); -Raxis(3)*Raxis(1) -Raxis(3)*Raxis(2) 1-Raxis(3)^2];
    Rsym2 = [Raxis(1)^2 Raxis(1)*Raxis(2) Raxis(1)*Raxis(3); Raxis(2)*Raxis(1) Raxis(2)^2 Raxis(2)*Raxis(3); Raxis(3)*Raxis(1) Raxis(3)*Raxis(2) Raxis(3)^2];
    Rssym = [0 Raxis(3) -Raxis(2); -Raxis(3) 0 Raxis(1); Raxis(2) -Raxis(1) 0];
    for jjj = 1:length(ANGLE)
        Rmat(:,:,jjj) = cos(ANGLE(jjj))*Rsym1 + Rsym2 - sin(ANGLE(jjj))*Rssym;
        t1(:,jjj) = Rmat(:,:,jjj)*p1;
        t2(:,jjj) = Rmat(:,:,jjj)*p2;
        t3(:,jjj) = Rmat(:,:,jjj)*p3;
    end
end