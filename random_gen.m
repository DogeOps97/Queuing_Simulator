function output = random_gen(choice, num)

    % x = zeros(1, num);
    seed = randi(1,1000000);

    rng_lcg = @() mod(mod(3472989573 * randi(1,1000000) + 1, 2^32), 100);
    rng_exp = @() -1 * 15 * log(1-rand());
    rng_uniform = @() (100) * rand();

    for(i=1:num)
        switch(choice)
            case 1
                seed = mod(3472989573 * seed + 1, 2^32);
                x(i) = mod(seed, 101);
            case 2
                while(true)
                    temp = int32(-1 * 25 * log(1-rand()));
                    if(temp >= 0 & temp <= 100)
                        x(i) = temp;
                        break;
                    end
                end

            case 3
                x(i) = int32(100 * rand());

            case 4
                x(i) = MersenneTwisterInt(randi(1,1000000), 1, 99, 1);
        end
    end
    output = x;