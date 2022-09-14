function output = new_funode(var,data,choose_n,time_interval)

n = choose_n;
sigma = 1524;
lambda = var(1);
k = 1 / (lambda*2.9);
I_0 = var(2);


[t,y]=ode45(@(t,y)simu_walk(t,y,n,lambda,I_0),[0:k:time_interval*k],zeros(1,n*n));


F = [];
cur_time = 0;


for i = 1 : length(data(1,:))
    tim = data(2,i);
    dist = 10.^data(1,i);
    if cur_time == tim
        for j = 1 : length(eq_dist)
            if abs(eq_dist(j) - dist) < 0.1
                F(i) =  eq_num(j);
            end
        end
    else
        cur_time = tim;
        [eq_dist,eq_num] = statistic_eq(t,y,tim,n);
        for j = 1 : length(eq_dist)
            if abs(eq_dist(j) - dist) < 0.1
                F(i) =  eq_num(j);
            end
        end        
    end
end
output = log10(sigma * F);
end