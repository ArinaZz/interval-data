pkg load interval
addpath(genpath('./m'))
addpath(genpath('./data'))

format long g

data1 = csvread("Ch1_800nm_0.23mm.csv")
data2 = csvread("Ch2_800nm_0.23mm.csv")
# remove first rows
#data1(1,:) = []
#data2(1,:) = []
#leave only mV values
data1_mv = data1(:,1)
data2_mv = data2(:,1)
# get N values
data1_n = transpose(1:length(data1_mv))
data2_n = transpose(1:length(data2_mv))

# get Epsilon
data1_eps = 1e-4
data2_eps = 1e-4

%setup a problem
data1_X = [ data1_n.^0 data1_n ];
data1_inf_b = data1_mv - data1_eps
data1_sup_b = data1_mv + data1_eps

[data1_tau, data1_w] = L_1_minimization(data1_X, data1_inf_b, data1_sup_b);
rady1 = data1_eps * data1_w;
yint1 = midrad(data1_mv, rady1);

[data1_tauZ, data1_wZ] = L_1_minimizationZ(data1_X, data1_inf_b, data1_sup_b);
radyZ1 = data1_eps * data1_wZ;
yintZ1 = midrad(data1_mv, radyZ1);

%%%%%%
data3_n = transpose(1:20)
data3_mv = data1_mv(1:20);

data3_X = [ data3_n.^0 data3_n ];
data3_inf_b = data3_mv - data2_eps
data3_sup_b = data3_mv + data2_eps

[data3_tauZ, data3_wZ] = L_1_minimizationZ(data3_X, data3_inf_b, data3_sup_b);


fileID = fopen('data/ChZ3.txt','w');
fprintf(fileID,'%g %g\n', data3_tauZ(1), data3_tauZ(2));
for c = 1 : length(data3_wZ)
  fprintf(fileID, "%g\n", data3_wZ(c));
end
fclose(fileID);
%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data2_X = [ data2_n.^0 data2_n ];
data2_inf_b = data2_mv - data2_eps
data2_sup_b = data2_mv + data2_eps

[data2_tau, data2_w] = L_1_minimization(data2_X, data2_inf_b, data2_sup_b);
rady2 = data2_eps * data2_w;
yint2 = midrad(data2_mv, rady2);


[data2_tauZ, data2_wZ] = L_1_minimizationZ(data2_X, data2_inf_b, data2_sup_b);
radyZ2 = data2_eps * data2_wZ;
yintZ2 = midrad(data2_mv, radyZ2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#крутая регрессия
fileID = fopen('data/ChZ1.txt','w');
fprintf(fileID,'%g %g\n', data1_tauZ(1), data1_tauZ(2));
for c = 1 : length(data1_wZ)
  fprintf(fileID, "%g\n", data1_wZ(c));
end
fclose(fileID);

fileID = fopen('data/ChZ2.txt','w');
fprintf(fileID,'%g %g\n', data2_tauZ(1), data2_tauZ(2));
for c = 1 : length(data2_wZ)
  fprintf(fileID, "%g\n", data2_wZ(c));
end
fclose(fileID);

fileID = fopen('data/yintZ1.txt','w');
for c = 1 : length(data1_w)
  fprintf(fileID, "%g\n", yint1(c));
end
fclose(fileID);

fileID = fopen('data/yintZ2.txt','w');
for c = 1 : length(data2_wZ)
  fprintf(fileID, "%g\n", yintZ2(c));
end
fclose(fileID);

#обычная регреесия
fileID = fopen('data/Ch1.txt','w');
fprintf(fileID,'%g %g\n', data1_tau(1), data1_tau(2));
for c = 1 : length(data1_w)
  fprintf(fileID, "%g\n", data1_w(c));
end
fclose(fileID);

fileID = fopen('data/Ch2.txt','w');
fprintf(fileID,'%g %g\n', data2_tau(1), data2_tau(2));
for c = 1 : length(data2_w)
  fprintf(fileID, "%g\n", data2_w(c));
end
fclose(fileID);

fileID = fopen('data/yint1.txt','w');
for c = 1 : length(data1_w)
  fprintf(fileID, "%g\n", yint1(c));
end
fclose(fileID);

fileID = fopen('data/yint2.txt','w');
for c = 1 : length(data2_w)
  fprintf(fileID, "%g\n", yint2(c));
end
fclose(fileID);

