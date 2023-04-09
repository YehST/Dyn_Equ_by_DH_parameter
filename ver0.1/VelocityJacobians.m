function Jv = VelocityJacobians(V, d_state)
    for i = 1:length(d_state)
        ans(:,i) = diff(V, d_state(i));
    end
    Jv = ans;
end