function A_Matrix = Each_homogeneous_Transformation(DH)
% [alpha a d theta type lastJoint centerOfMass]
alpha = DH(:, 1);
a = DH(:, 2);
d = DH(:, 3);
theta = DH(:, 4);
try
    double(DH(1, 7)); %if error, it will not do this.
    Customized_Centroid_flag = 0;
catch
    Customized_Centroid_flag = 1;
end
for i = 1:length(DH(:,1))
    A = [cos(theta(i)) -sin(theta(i))*cos(alpha(i)) sin(theta(i))*sin(alpha(i)) a(i)*cos(theta(i));
        sin(theta(i)) cos(theta(i))*cos(alpha(i)) -cos(theta(i))*sin(alpha(i)) a(i)*sin(theta(i));
        0                sin(alpha(i))                cos(alpha(i))              d(i)       ;
        0                      0                             0                    1        ];
    A_Matrix.(sprintf('o%d%d', DH(i,6), i)) = A;
    if ~Customized_Centroid_flag
        Ac = [cos(theta(i)) -sin(theta(i))*cos(alpha(i)) sin(theta(i))*sin(alpha(i)) a(i)*DH(i, 7)*cos(theta(i));
            sin(theta(i)) cos(theta(i))*cos(alpha(i)) -cos(theta(i))*sin(alpha(i)) a(i)*DH(i, 7)*sin(theta(i));
            0                sin(alpha(i))                cos(alpha(i))              d(i)*DH(i, 7)       ;
            0                      0                             0                    1        ];
        A_Matrix.(sprintf('o%d%dc', DH(i,6), i)) = Ac;
    end
end
end