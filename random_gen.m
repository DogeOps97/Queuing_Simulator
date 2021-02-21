function output = random_gen(choice, num)
    seed = randi(1,1000000);

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