function G = GetGMatrix(U, state)
    G = sym('G', [length(state), 1]);
    for i = 1:length(state)
        G(i) = diff(U, state(i));
    end
end