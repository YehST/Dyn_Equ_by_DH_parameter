function T_Matrix = homogeneous_Matrix(DH, A_Matrix)
    T_Matrix.o00 = sym([1 0 0 0; 0 1 0 0 ; 0 0 1 0; 0 0 0 1]);
    try
        double(DH(1, 7)); %if error, it will not do this.
        Customized_Centroid_flag = 0;
    catch
        Customized_Centroid_flag = 1;
    end
    for i = 1:length(DH(:,1))
        T_Matrix.(sprintf('o%d%d', 0, i)) = simplify(T_Matrix.(sprintf('o%d%d', 0, DH(i,6)))*A_Matrix.(sprintf('o%d%d', DH(i,6), i)));
        if(~Customized_Centroid_flag)
            T_Matrix.(sprintf('o%d%dc', 0, i)) = simplify(T_Matrix.(sprintf('o%d%d', 0, DH(i,6)))*A_Matrix.(sprintf('o%d%dc', DH(i,6), i)));
        end
    end
end