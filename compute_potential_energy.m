function U = compute_potential_energy(DH, state, T, Mass)
    syms g
    U = 0;
    n = 1;
    try
        double(DH(1, 7)); %if error, it will not do this.
        Customized_Centroid_flag = 0;
    catch
        Customized_Centroid_flag = 1;
    end
    for i = 1:length(DH(:,1))
        if Customized_Centroid_flag
            if (DH(i, 7)=='T')
                U = U + Mass(n)*T.(sprintf('o%d%d', 0, i))(3, 4)*g;
                n = n+1;
            end
        else
            if ismember(1, has(DH(i, 1:4), state(n)))
                U = U + Mass(n)*T.(sprintf('o%d%dc', 0, i))(3, 4)*g;
                n = n+1;
            end
        end
    end
end