function plotRotation(phi,r,Q)
% PLOT ROTATION: This function is given before the exercises. can be used
% for plot the rotation commanded, both for debugging and clarification
% purposes.
%
%   The function requires the equivalent anlge-axis representation, in
%   order: angle, axis. And as third input parameter the rotation matrix
%   associated with the rotation. 

    %Since the direction of the rotation (CW or CCW) cannot be
    %determined from the earlier calculation (acos(X) will always
    %output a value within [0 pi]), we are going to use the
    %skew-symmetric component of the matrix Q to figure that out.
    tol = 1e-4; %define tollerance
    %Define reference configuration p_i
    p1 = [1; 0; 0];
    p2 = [0; 1; 0];
    p3 = [0; 0; 1];
    
    %Define present configuration basis t_i
    t1 = [Q*p1];
    t2 = [Q*p2];
    t3 = [Q*p3];
    Q_ss = 0.5*(Q -Q'); %Skew-symmetric component of Q
    
    %If phi = n*pi, the skew-symmetric component of Q will be
    %zero. In this case, the direction of rotation cannot be determined.
    
    %Check if skew symmetric component is equal to zero
    if (abs(Q_ss - zeros(3,3)) < tol*ones(3,3) == ones(3,3)) %Special case where phi = n*pi, therefore Q_ss = 0
        if (abs(phi/pi - round(phi/pi)) < tol)
            direction = 'indeterminate direction';
        end
    else
        %Calculate the skew-symmetric component from Euler's
        %representation using two different directions
        %iii = 2: CCW, iii = 1: CW
        for iii = [2 1]
            Q_ss_calc = -sin(phi*(-1)^iii)*[0 r(3) -r(2); -r(3) 0 r(1); r(2) -r(1) 0];
    
            %Check if the skew-symmetric components of Q
            %calculated in two different manners are equal.
            %Try the other direction if they are not equal.
            if (abs(Q_ss - Q_ss_calc) < tol*ones(3,3)) == ones(3,3)
                if iii == 1
                    direction = 'clockwise';
                elseif iii == 2
                    direction = 'counterclockwise';
                end
            end
        end
    end
    %%%%%%%%%%%%% START ANIMATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if exist('direction', 'var') && exist('phi', 'var') && exist('r', 'var')
        
            %Drawing and animating the basis vectors
            figure('Color', 'w', 'Position', [375 198 622 388]); hold on;
            title([num2str(abs(phi)*(180/pi)) ' deg ' direction ' rotation about the axis \bfr\rm = [' num2str(r(1)) '; ' num2str(r(2)) '; ' num2str(r(3)) ']']);
            axis equal; axis([-1 1 -1 1 -1 1])
            xlabel('\itx'); ylabel('\ity'); zlabel('\itz', 'rotation', 0);
            view([135 30]);
            grid on;
        
    
            %Fixed basis {p1, p2, p3}
            p1v = quiver3(0,0,0,p1(1), p1(2), p1(3), 'k', 'LineWidth', 2);
            text(p1(1), p1(2), p1(3), '\bfi\rm_{a}');
            p2v = quiver3(0,0,0,p2(1), p2(2), p2(3), 'k', 'LineWidth', 2);
            text(p2(1), p2(2), p2(3), '\bfj\rm_{a}');
            p3v = quiver3(0,0,0,p3(1), p3(2), p3(3), 'k', 'LineWidth', 2);
            text(p3(1), p3(2), p3(3), '\bfk\rm_{a}');
    
            %Axis of rotation                       
            rv = quiver3(0,0,0,r(1), r(2), r(3), 'r', 'LineWidth', 2); hold on;
            text(r(1),r(2),r(3),'\bfr');
    
            [t1seq, t2seq, t3seq, Qseq] = calcRmatrix(phi, r, p1, p2, p3, 100);
            
            %Moving basis {t1, t2, t3}
            t1v = quiver3(0, 0, 0, t1seq(1,1), t1seq(2,1), t1seq(3,1), 'b', 'LineWidth', 2);
            t2v = quiver3(0, 0, 0, t2seq(1,1), t2seq(2,1), t2seq(3,1), 'b', 'LineWidth', 2);
            t3v = quiver3(0, 0, 0, t3seq(1,1), t3seq(2,1), t3seq(3,1), 'b', 'LineWidth', 2);
    
            %Trace the path of the moving basis
            t1p = line(t1seq(1,1), t1seq(2,1), t1seq(3,1), 'LineStyle', ':', 'Color', 'k', 'LineWidth', 0.3);
            t2p = line(t2seq(1,1), t2seq(2,1), t2seq(3,1), 'LineStyle', ':', 'Color', 'k', 'LineWidth', 0.3);
            t3p = line(t3seq(1,1), t3seq(2,1), t3seq(3,1), 'LineStyle', ':', 'Color', 'k', 'LineWidth', 0.3);
    
            for jjj = 1:100
                if jjj == 1
                    pause;
                end
                set(t1v, 'xdata', 0, 'ydata', 0, 'zdata', 0, 'udata', t1seq(1,jjj), 'vdata', t1seq(2,jjj), 'wdata', t1seq(3,jjj), 'Color', 'b', 'LineWidth', 2);
                set(t2v, 'xdata', 0, 'ydata', 0, 'zdata', 0, 'udata', t2seq(1,jjj), 'vdata', t2seq(2,jjj), 'wdata', t2seq(3,jjj), 'Color', 'b', 'LineWidth', 2);
                set(t3v, 'xdata', 0, 'ydata', 0, 'zdata', 0, 'udata', t3seq(1,jjj), 'vdata', t3seq(2,jjj), 'wdata', t3seq(3,jjj), 'Color', 'b', 'LineWidth', 2);
                set(t1p, 'xdata', t1seq(1,1:jjj), 'ydata', t1seq(2,1:jjj), 'zdata', t1seq(3,1:jjj));
                set(t2p, 'xdata', t2seq(1,1:jjj), 'ydata', t2seq(2,1:jjj), 'zdata', t2seq(3,1:jjj));
                set(t3p, 'xdata', t3seq(1,1:jjj), 'ydata', t3seq(2,1:jjj), 'zdata', t3seq(3,1:jjj));
                drawnow;
            end
    
            text(t1seq(1,end), t1seq(2,end), t1seq(3,end), '\bfi\rm_{b}');
            text(t2seq(1,end), t2seq(2,end), t2seq(3,end), '\bfj\rm_{b}');
            text(t3seq(1,end), t3seq(2,end), t3seq(3,end), '\bfk\rm_{b}');
    else
        disp(['det(Q) = ' num2str(det(Q)) ' ~= 1']);
        disp('Q is not a proper-orthogonal tensor.'); disp(' ');           
        disp('Q*Q'' = '); disp(num2str(Q*Q')); disp('is not equal to identity');
        disp('Q is not an orthogonal tensor.'); disp(' ');
        disp('Q = '); disp(num2str(Q)); disp('is not a 3x3 rotation tensor.'); disp(' ');
         
    end
    
end

