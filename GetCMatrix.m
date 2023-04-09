function C = GetCMatrix(D, state, d_state)
    arguments 
        D {mustBeSquaredMatrix(D)}
        state, d_state {mustBeEqualSize(state, d_state)}
    end
    c = sym('c', [length(D), length(D), length(state)]);
    temp = sym('C', [length(D), length(D)]);
    C = sym('C', [length(D), length(D)]);
    for i = 1:length(state)
        for j = 1:length(D)
            for k = 1:length(D)
                c(i,j,k) = 0.5*(diff(D(k, j), state(i))+diff(D(k, i), state(j))-diff(D(i, j), state(k)));
            end
        end
    end
    for j = 1:length(D)
        for k = 1:length(D)
            for i = 1:length(state)
                temp(k,j) = temp(k,j) + c(i,j,k)*d_state(i);
            end
        end
    end
    C = subs(temp, C, zeros(length(D), length(D)));
    
end
function mustBeSquaredMatrix(D)
    % Test for equal size
    tmp = size(D);
    if ~isequal(tmp(1),tmp(2))
        eid = 'Size:notASquaredMatrix';
        msg = 'Inputs must squared matrix.';
        throwAsCaller(MException(eid,msg))
    end
end
function mustBeEqualSize(A, B)
    % Test for equal size
    if ~isequal(size(A),size(B))
        eid = 'Size:notEqual';
        msg = 'Inputs must have equal size.';
        throwAsCaller(MException(eid,msg))
    end
end