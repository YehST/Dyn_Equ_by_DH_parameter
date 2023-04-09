function Jv = T_velocityJacobian(T_Matrix, DH, state, End_linked)
    R_Matrix = Rotation_Matrix(DH, T_Matrix);
    n = 1; 
    Jv = sym(zeros(3, length(state)));
    try
        double(DH(1, 7)); %if error, it will not do this.
        Customized_Centroid_flag = 0;
    catch
        Customized_Centroid_flag = 1;
    end
    for i = 1:End_linked
        if Customized_Centroid_flag
            if (DH(i, 7)=='T')
                
                if(DH(i, 5)=='R')
                    Jv(:, n) = cross(R_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))*sym([0;0;1]), (T_Matrix.(sprintf('o%d%d', 0, End_linked))([1:3],4)-T_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))([1:3],4)));
                else
                    Jv(:, n) = R_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))*sym([0;0;1]);
                end
                n = n+1;
            end
        else
            if ismember(1, has(DH(i, 1:4), state(n)))
                if(DH(i, 5)=='R')
                    Jv(:, n) = cross(R_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))*sym([0;0;1]), (T_Matrix.(sprintf('o%d%dc', 0, End_linked))([1:3],4)-T_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))([1:3],4)));
                else
                    Jv(:, n) = R_Matrix.(sprintf('o%d%d', 0, DH(i, 6)))*sym([0;0;1]);
                end
                n = n+1;
            end
        end
    end
    % 檢查是否有未使用之狀態變數因DH之定義方式而產生
    has_state_dh = sym([]);
    count = End_linked; % 倒算子
    for j = End_linked:-1:1
        if ismember(1, has(DH(count, :), state)) %判斷此行是否有狀態變數
            has_state_dh(end+1,:) = DH(count, :);
        end
        count = int8(DH(count, 6));
        if count == 0
            break
        end
    end
    for k = 1:length(state)
        if(~ismember(1, has(has_state_dh, state(k))))
            Jv(:, k) = [0;0;0];
        end
    end
    Jv = simplify(Jv);
end