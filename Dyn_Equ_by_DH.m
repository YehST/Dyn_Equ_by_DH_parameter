function [M, C, G] = Dyn_Equ_by_DH(DH, state, d_state, Mass, U)
% Derived dynamic equation by DH parameter.
% input:
% - DH: DH = [alpha a d theta type PreviousCoor CenterOfMass]
% -     all the argument should be 'sym' type.
% -     the first four are the standard DH parameter of robot.
% -     the fifth part 'type' is the type of joint, it should be Prismatic('P') or Revolute('R').
% -     the sixth part 'PreviousCoor' mean the last one coordinate of this one.
% -     the seventh part 'CenterOfMass' can be defined in two different type.
% -     - in double, the number mean the position of the center of mass on the next link, the maxium value is one.
% -     - in string, the word mean that if the coordinate is a center of mass of the link, the value should be True('T') or False('F').
% - state: The system's state, should be 'sym' matrix type.
% - d_state: The system's first order differential state, should be 'sym' matrix type.
% - Mass: The mass of each linked, the length of this matrix should be same as the length of state matrix.
% - U: The system's potential energy, it will be a sym function, can be ignore, if this argument is not entered, it will compute with DH
% -     parameter automatically.
% return:
% - M: inertia matrix.
% - C: coriolis/centrifugal matrix.
% - G: gravity vector.


    narginchk(4,5) %% Limit the number of input.
    A = Each_homogeneous_Transformation(DH);
    T = homogeneous_Matrix(DH, A);

    M = GetMMatrix(DH, state, Mass);
    C = GetCMatrix(M, state, d_state);
    if nargin == 4
        U = compute_potential_energy(DH, state, T, Mass);
    end
    G = GetGMatrix(U, state);
end