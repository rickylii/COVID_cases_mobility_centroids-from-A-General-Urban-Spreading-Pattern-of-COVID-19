
clear variables
close all
p_x = readtable('beijing_point_x.csv');p_x=p_x{:,:};
p_y = readtable('beijing_point_y.csv');p_y=p_y{:,:};
p_z = readtable('beijing_point_z.csv');p_z=p_z{:,:};

normal_dis = [];
timestamps = [];
normal_num = [];

cut_standard = 35;
dis = 10.^(p_x);
choose_n = cut_standard * 2 + 3;
time_interval = 30;

count = 0;
for i = 1 : length(p_x)
    if dis(i) < cut_standard
        count = count + 1;
        normal_dis(count) = p_x(i);
        timestamps(count) = p_y(i);
        normal_num(count) = p_z(i);
    end
end


lb = [0.1,0.0001,-3];
ub = [5,0.03,-1.5];
var = lsqcurvefit(@(var,data) new_funode(var,data,choose_n,time_interval),[1.15;0.03],[normal_dis;timestamps],normal_num,lb,ub)