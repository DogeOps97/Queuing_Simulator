function spectral_test(choice)
    seed = randi(1, 1000000);

    for(i=1:300)
        % seed = mod(3472989573 * seed + 1, 2^32);
        % seed = mod(5 * seed + 1, 2^32);
        % x(i) = seed;

        % x(i) = MersenneTwisterInt(seed, 0, 100, 1);
        % x(i) = int32(-1 * 25 * log(1-rand()));
        x(i) = int32(100 * rand());
        seed = randi(1, 1000000);
    end

    x;
    y = [0, x];
    y(301) = [];
    z = [0, y];
    z(301) = [];

    hist(y, 100)
    figure(2)
    plot(x,y, 'bx')
    figure(3)
    plot3(x,y,z,'bx')