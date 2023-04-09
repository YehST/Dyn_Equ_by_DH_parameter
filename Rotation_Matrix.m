function R_Matrix = Rotation_Matrix(DH, T_Matrix)
    R_Matrix.o00 = T_Matrix.o00([1:3],[1:3]);
    try
        double(DH(1, 7)); %if error, it will not do this.
        Customized_Centroid_flag = 0;
    catch
        Customized_Centroid_flag = 1;
    end
    for i = 1:length(DH(:,1))
        R_Matrix.(sprintf('o%d%d', 0, i)) = T_Matrix.(sprintf('o%d%d', 0, i))([1:3],[1:3]);
        if ~Customized_Centroid_flag
            R_Matrix.(sprintf('o%d%dc', 0, i)) = T_Matrix.(sprintf('o%d%dc', 0, i))([1:3],[1:3]);
        end
    end
end