function output = MersenneTwisterFloat(seed, count)
	k = 16807;
	j = power(2, 31) - 1;
	seed = mod(seed,  10267);
	seed = seed *  115249;
	period = power(2, 30);
	for i=1:count
		seed = mod((k * seed), j);
		table(i) = seed / j;
		period = period - 1;
		if (period == 0)
			printf("%s\n", "Pseudorandom period nearing");
			period = pow(2, 30);
		end

	end

	output = table;