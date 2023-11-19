%%angle_vec_ = [10*pi/180 20*pi/180 30*pi/180]

angle_vec = [10 20 30]
angle_vec = deg2rad(angle_vec)  

A1 = [0 0 0]
B1 = [1 1 1]
C1 = [2 2 2]

A2 = apply_euler(A1, angle_vec)
B2 = apply_euler(B1, angle_vec)
C2 = apply_euler(C1, angle_vec)

DA = euclid_dist(A1, A2)
DB = euclid_dist(B1, B2)
DC = euclid_dist(C1, C2)



%% Function definition for deg2rad  %%%
%% Converts a 1x3 vector expressed in degrees
%% into a new 1x3 vector in rads
%% deg_vec: 1x3 vector (in degrees)
%% return: 1x3 vector (in rads)
%%
%% Note: angle φ in degrees is ω rads based on
%% φ/360 = ω/2π, π=3.1415926.. constant
%% Therefore ω=2πφ/360=πφ/180
function rad_vec = deg2rad(deg_vec)
   rad_vec = (deg_vec * pi)/180
end

%% Function definition for euler transformation %%%
%% Uses the euler tranformation matrices (3x3) to
%% tranform initial coordinate point (a 1x3 vector) to a new point after
%% applying pitch-yaw-roll (a 1x3 vector in rads)
%% init_pont: 1x3 vector
%% angle_vector: 1x3 vector (values in rads)
%% return: new point (1x3 vector)
function newpoint = apply_euler(init_point, angle_vec)
   psi = angle_vec(1,1)
   th  = angle_vec(1,2)
   phi = angle_vec(1,3)
   Rx = [1 0 0; 0 cos(psi) -sin(psi); 0 sin(psi) cos(psi)]
   Ry = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)]
   Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1]

   newpoint = ((init_point*Rx)*Ry)*Rz
end


%% Function definition for euclidean distance %%%
%% Takes as input 2 3D points - 2 vectors 1x3
%% and returns the euclidean distance
%% start_point: 1x3 vector
%% end_point:   1x3 vector
%% return:      number
function res = euclid_dist(start_point, end_point)
  diff_vect = end_point - start_point 
  res = sqrt(diff_vect(1,1)^2 + diff_vect(1,2)^2 +diff_vect(1,3)^2)
end
