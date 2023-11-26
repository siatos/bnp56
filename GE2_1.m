%%
angle_vec = [10 20 30]          %% in degreees      
angle_vec = deg2rad(angle_vec)  %% in rads

%% initial points
A1 = [0; 0; 0]
B1 = [1; 1; 1]
C1 = [2; 2; 2]

R = rotation_matrix(angle_vec)  %% rotation matrix

A2 = R * A1
B2 = R * B1
C2 = R * C1

DA = euclid_dist(A1, A2)
DB = euclid_dist(B1, B2)
DC = euclid_dist(C1, C2)

%% Function Definitions

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

%% Note:
%% since we will apply matrix multiplication 
%% each New_Point is derived from the Initial_Point using the formula
%% New_Point = (Rz*Ry*Rx)*Initial_Point 
%% Both points are 3x1 vectors to satisfy the matrix multiplication 
%% R=Rz*Ry*Rx is a 3x3 matrix the final rotation matrix
%% 
%%  Rx is the Pitch rotation around x-axis
%%  Ry is the Yaw rotation around y-axis
%%  Rz is the Roll rotation around z-axis
%% see:
%% Glabe, J. (2021). Euler Angles and Roll Pitch Yaw Representation. 
%% In: Ang, M.H., Khatib, O., Siciliano, B. (eds) Encyclopedia of Robotics. 
%% Springer, Berlin, Heidelberg. https://doi.org/10.1007/978-3-642-41610-1_129-1


%% Function definition for euler transformation %%%
%% Uses the euler tranformation matrices (3x3) to
%% calculate rotation matrix
%% angle_vec: 1x3 vector (values in rads)
%% return: rotation matrix (3x3)
function rot_matrix = rotation_matrix(angle_vec)
   psi = angle_vec(1,1)
   th  = angle_vec(1,2)
   phi = angle_vec(1,3)
   Rx = [1 0 0; 0 cos(psi) -sin(psi); 0 sin(psi) cos(psi)]
   Ry = [cos(th) 0 sin(th); 0 1 0; -sin(th) 0 cos(th)]
   Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1]

   rot_matrix = Rz*Ry*Rx
end


%% Function definition for euclidean distance %%%
%% Takes as input 2 3D points - 2 column vectors 3x1
%% and returns the euclidean distance
%% start_point: 3x1 vector column vector
%% end_point:   3x1 vector column vector
%% return:      number
function res = euclid_dist(start_point, end_point)
  diff_vect = end_point - start_point 
  res = sqrt(diff_vect(1,1)^2 + diff_vect(2,1)^2 +diff_vect(3,1)^2)
end
