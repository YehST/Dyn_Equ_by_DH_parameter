function M = GetMMatrix(DH, state, Mass)
    A = Each_homogeneous_Transformation(DH);
    T = homogeneous_Matrix(DH, A);
    R = Rotation_Matrix(DH, T);
    M = 0;
    In = 1;
    n = 1;
%     count = length(DH(:,1)); % 倒算子
    
    try
        double(DH(1, 7)); %if error, it will not do this.
        Customized_Centroid_flag = 0;
    catch
        Customized_Centroid_flag = 1;
    end

    for i = 1:length(DH(:,1))
        if Customized_Centroid_flag
            if (DH(i, 7)=='T')
                Jw.(sprintf('o%d%d', 0, n)) = T_AngularVelocityJacobian(T, DH, state, i);
                Jv.(sprintf('o%d%d', 0, n)) = T_velocityJacobian(T, DH, state, i);

%                 has_state_dh = sym([]);
%                 for j = i:-1:1
%                     if ismember(1, has(DH(count, :), state)) %判斷此行是否有狀態變數
%                         has_state_dh(end+1,:) = DH(count, :);
%                     end
%                     count = DH(count, 6);
%                     if count == 0
%                         break;
%                     end
%                 end
%                 for k = 1:length(state)
%                     if(~ismember(1, has(has_state_dh, state(k))))
%                         Jw.(sprintf('o%d%d', 0, n))(:, 3) = [0;0;0];
%                         Jv.(sprintf('o%d%d', 0, n))(:, 3) = [0;0;0];
%                     end
%                 end

                if(DH(i, 5) == 'R')
                    I.(sprintf('o%d%d', 0, In)) = sym(sprintf('I%d', In), [3,3]);
                    M = M + Mass(n)*Jv.(sprintf('o%d%d', 0, n)).'*Jv.(sprintf('o%d%d', 0, n))+Jw.(sprintf('o%d%d', 0, n)).'*R.(sprintf('o%d%d', 0, i))*I.(sprintf('o%d%d', 0, In))*R.(sprintf('o%d%d', 0, i)).'*Jw.(sprintf('o%d%d', 0, n));
                    In = In+1;
                else
                    M = M + Mass(n)*Jv.(sprintf('o%d%d', 0, n)).'*Jv.(sprintf('o%d%d', 0, n));
                end
                n = n+1;
            end
        else
            if ismember(1, has(DH(i, 1:4), state(n)))
                Jw.(sprintf('o%d%d', 0, n)) = T_AngularVelocityJacobian(T, DH, state, i);
                Jv.(sprintf('o%d%d', 0, n)) = T_velocityJacobian(T, DH, state, i);
                if(DH(i, 5) == 'R')
                    I.(sprintf('o%d%d', 0, In)) = sym(sprintf('I%d', In), [3,3]);
                    M = M + Mass(n)*Jv.(sprintf('o%d%d', 0, n)).'*Jv.(sprintf('o%d%d', 0, n))+Jw.(sprintf('o%d%d', 0, n)).'*R.(sprintf('o%d%d', 0, i))*I.(sprintf('o%d%d', 0, In))*R.(sprintf('o%d%d', 0, i)).'*Jw.(sprintf('o%d%d', 0, n));
                    In = In+1;
                else
                    M = M + Mass(n)*Jv.(sprintf('o%d%d', 0, n)).'*Jv.(sprintf('o%d%d', 0, n));
                end
                n = n+1;
            end
        end
    end
end