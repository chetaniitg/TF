E = 29.5e6; A = 1; 

% Element 1
x1 = [0, 0, 40, 0];
k1 = elestiff(E, A, x1);

% Element 2
x2 = [40, 0, 40, 30];
k2 = elestiff(E, A, x2);

% Element 3
x3 = [40, 30, 0, 30];
k3 = elestiff(E, A, x3);

% Element 4
x4 = [40, 30, 0, 0];
k4 = elestiff(E, A, x4);

% Assembly matrix
K = zeros(8,8);
F = zeros(8,1);

K(1:4,1:4) = k1(1:4,1:4);
K(3:6,3:6) = K(3:6,3:6) + k2(1:4,1:4);
K(5:8,5:8) = K(5:8,5:8) + k3(1:4,1:4);
K([5,6,1,2],[5,6,1,2]) = K([5,6,1,2],[5,6,1,2]) + k4(1:4,1:4);

F(3) = 20000;
F(6) = -25000;

% Imposition of B.C.
Kreduce = K([3,5:6],[3,5:6]);
Freduce = F([3,5:6]);

% Finding Solution
ureduce = inv(Kreduce)*Freduce;

% Finding Reaction Force
un = zeros(8,1);
un([3,5:6]) = ureduce
Fr = K*un



% % ==============================================
% %% Printing Intermediate Result to The Output File
% % ------------------------------------------------

fid=fopen('Steps','w');
fprintf(fid,'The Element Stiffness matrices are\n');
fprintf(fid,'===================================\n');
fprintf(fid,'E = %12.4e, A = %12.4e\n\n',E,A);
fprintf(fid,'Ke1 where xe1 = %12.4e, ye1 = %12.4e, xe2 = %12.4e, ye2 = %12.4e\n',x1(1:4));
fprintf(fid,'------------------------------------------------------------\n\n');
for i = 1:4
   fprintf(fid,'%14.4e\t%14.4e\t%14.4e\t%14.4e\n\n',k1(i,1:4));
end
fprintf(fid,'Ke2 where xe1 = %12.4e, ye1 = %12.4e, xe2 = %12.4e, ye2 = %12.4e\n',x2(1:4));
fprintf(fid,'------------------------------------------------------------\n\n');
for i = 1:4
   fprintf(fid,'%14.4e\t%14.4e\t%14.4e\t%14.4e\n\n',k2(i,1:4));
end
fprintf(fid,'Ke3 where xe1 = %12.4e, ye1 = %12.4e, xe2 = %12.4e, ye2 = %12.4e\n',x3(1:4));
fprintf(fid,'------------------------------------------------------------\n\n');
for i = 1:4
   fprintf(fid,'%14.4e\t%14.4e\t%14.4e\t%14.4e\n\n',k3(i,1:4));
end
fprintf(fid,'Ke4 where xe1 = %12.4e, ye1 = %12.4e, xe2 = %12.4e, ye2 = %12.4e\n',x4(1:4));
fprintf(fid,'------------------------------------------------------------\n\n');
for i = 1:4
   fprintf(fid,'%14.4e\t%14.4e\t%14.4e\t%14.4e\n\n',k4(i,1:4));
end

fprintf(fid,'\n\nThe Global Stiffness matrix is\n');
fprintf(fid,'==================================\n\n');
fprintf(fid,'K\n');
fprintf(fid,'--\n');
for i = 1:8
   fprintf(fid,'%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\n\n',K(i,1:8));
end

fprintf(fid,'\n\nThe Global Load Vector is\n');
fprintf(fid,'==================================\n\n');
fprintf(fid,'F\n');
fprintf(fid,'--\n');
for i = 1:8
   fprintf(fid,'%12.4e\n\n',F(i));
end

fprintf(fid,'\n\nImposition of Boundary Condition\n');
fprintf(fid,'==================================\n\n');
fprintf(fid,'K u = F\n');
fprintf(fid,'--------\n');
for i = 1:8
   fprintf(fid,'%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t%12.4e\t\t%12.4e\n\n',K(i,1:8),F(i));
end

fprintf(fid,'\n\nReduced Equations\n');
fprintf(fid,'=======================\n\n');
fprintf(fid,'K_reduce u = F_reduce\n');
fprintf(fid,'--------\n');
for i = 1:3
   fprintf(fid,'%12.4e\t%12.4e\t%12.4e\t\t\t\t%12.4e\n\n',Kreduce(i,1:3),Freduce(i));
end

fprintf(fid,'\n\nThe Final Solution\n');
fprintf(fid,'=========================\n\n');
fprintf(fid,'un\n');
fprintf(fid,'--\n');
for i = 1:8
   fprintf(fid,'%12.4e\n\n',un(i));
end

fprintf(fid,'\n\nThe Reaction Forces can be found from\n');
fprintf(fid,'=========================================\n\n');
fprintf(fid,'F = K*un\n');
fprintf(fid,'---------\n');
for i = 1:8
   fprintf(fid,'%12.4e\n\n',Fr(i));
end

