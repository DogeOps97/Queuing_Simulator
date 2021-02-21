function output = random_gen_nodupe(choice, num)
    seed = randi(1, 1000000);

    i = 1;
    while(i<=num)
        switch(choice)
            case 1
                seed = mod(3472989573 * seed + 1, 2^32);
                temp = mod(seed, 99) + 1;
            case 2
                while(true)
                    temp = int32(-1 * 50 * log(1-rand()));
                    if(temp > 0 & temp < 100)
                        temp = 100 - temp;
                        break;
                    end
                end

            case 3
                temp = int32(98 * rand()) + 1;

            case 4
                temp = MersenneTwisterInt(randi(1,1000000), 1, 99, 1);
        end
        dupe = false;
        for(j=1:i-1)
            if(temp == x(j))
                dupe = true;
            end
        end
        if(dupe == true)
            i = i - 1;
        else
            x(i) = temp;
        end
        i = i + 1;
    end
    output = x;