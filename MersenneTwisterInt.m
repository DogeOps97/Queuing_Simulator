function output = MersenneTwisterInt(seed, min, max, count)
	k = 16807;
	j = power(2, 31) - 1;
	seed = mod(seed,  10267);
	seed = seed *  115249;
	period = power(2, 30);
	for i=1:count
		seed = mod((k * seed), j);
		%table(i) = seed / j;
		table(i) = floor((max - min + 1) * (seed / j) + min);
		period = period - 1;
	end

	output = table;