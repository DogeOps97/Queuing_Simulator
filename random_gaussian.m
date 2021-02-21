function output = random_gaussian(num_cust, mean, std_dev)
    for(i=1:num_cust)
        seed = rand();
        x(i) = sqrt(2)*std_dev*(erfinv(2*seed - 1)) + mean;
    end

    output = x;