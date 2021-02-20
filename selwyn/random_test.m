function output = rng(choice, avg, a, b, seed)
    range = b - a;
    
    rng_lcg = @(avg, range) mod(mod(3472989573 * seed + 1, 2^32), range) + avg / 2;
    rng_exp = @(avg) -1 * avg * log(1-rand());
    rng_uniform = @(a, b) a + (b - a) * rand();
    
    switch(choice)
        case 1
            output = rng_lcg(avg, range);
        case 2
            while(true)
                temp = rng_exp(avg);
                if(temp >= a & temp <= b)
                    output = temp;
                    break;
                end
            end
        case 3
            output = rng_uniform(a, b);
    end