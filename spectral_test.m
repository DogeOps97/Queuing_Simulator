function spectral_test(choice)
    seed = randi(1, 1000000);

    printf('\n1. LCG with optimal parameters.\n');
    printf('2. LCG with non-optimal parameters.\n');
    printf('3. Exponential Distribution.\n');
    printf('4. Uniform Distribution.\n');
    printf('5. Mersenne Twister.\n');
    printf('6. Gaussian Distribution.\n\n');

    choice = input('Choose which generator to do a spectral test on : ');

    num_itr = input('Choose the number of iterations : ');

    switch(choice)
        case 1
            for(i=1:num_itr)
                seed = mod(3472989573 * seed + 1, 2^32);
                x(i) = seed;
            end

        case 2
            for(i=1:num_itr)
                seed = mod(5 * seed + 1, 2^32);
                x(i) = seed;
            end

        case 3
            for(i=1:num_itr)
                x(i) = int32(-1 * 25 * log(1-rand()));
            end

        case 4
            for(i=1:num_itr)
                x(i) = int32(100 * rand());
            end
        
        case 5
            for(i=1:num_itr)
                x(i) = MersenneTwisterInt(seed, 0, 100, 1);
                seed = randi(1, 1000000);
            end

        case 6
            for(i=1:num_itr)
                seed = rand();
                x(i) = sqrt(2)*15*(erfinv(2*seed - 1)) + 100;
            end

    end

    x;
    y = [0, x];
    y(num_itr + 1) = [];
    z = [0, y];
    z(num_itr + 1) = [];

    hist(x, 100)
    figure(2)
    plot(x,y, 'bx')
    figure(3)
    plot3(x,y,z,'bx')