% 2022-01-07


epsilon0 = 10^(-4)

%  2022-12-27
% epsilon0 = 10 *10^(-4)
  stepR = 0.01
#[x1, x2, FNstr, Lambdastr, Threadstr] = getSolar2 (FN1, FN2);

dirData = 'C:\Users\arina\Documents\funny\Solar-Data-main'
cd(dirData), pwd

x1 = csvread("Ch1_800nm_0.23mm.csv")
x2 = csvread("Ch2_800nm_0.23mm.csv")

FNstr = transpose(1:length(x1))

input1 = x1(:,1);
input2 = x2(:,1);
xx1 = 1:length(input1);
epsilon = epsilon0 * ones(length(input1),1);

Angle_points = [ 50 151 ]
% 2022-03-21
Angle_points = [ 25 176 ]
%
ROI_array = zeros(numel(Angle_points)+1,2)
ROI_array (1,1) = 1
ROI_array (1,2) = Angle_points(1)-1
ROI_array (2,1) = Angle_points(1)
ROI_array (2,2) = Angle_points(2)-1
ROI_array (end,1) =  Angle_points(2)
ROI_array (end,2) = length(input1)


figure
subplot(1,2,1)
hold on
for ii = 1:length(ROI_array)
  clear yp;
  ROI_now = ROI_array(ii,1):  ROI_array(ii,2);
  data_now = input1(ROI_now);
  in_now = ROI_now;
  [tau1, w1, yint] = DataLinearModelZ (data_now, epsilon0);
  h1=errorbar (in_now, data_now, epsilon(ROI_now), ".b");
%
  yp= tau1(1) +tau1(2)*(in_now-in_now(1)+1);


h2=plot(in_now, yp, '-y')

  end
set(gca, 'fontsize', 14)
ylim([min(input1)-epsilon0 max(input1)+epsilon0 ] )
xlim([1 200])
subplot(1,2,2)
hold on
for ii = 1:length(ROI_array)
  clear yp;
  ROI_now = ROI_array(ii,1):  ROI_array(ii,2);
  data_now = input2(ROI_now);
  in_now = ROI_now;
  [tau1, w1, yint] = DataLinearModelZ (data_now, epsilon0);
  h1=errorbar (in_now, data_now, epsilon(ROI_now), ".b");
%
  yp= tau1(1) +tau1(2)*(in_now-in_now(1)+1);


h2=plot(in_now, yp, '-y')

  end
set(gca, 'fontsize', 14)
ylim([min(input2)-epsilon0 max(input2)+epsilon0 ] )
xlim([1 200])

