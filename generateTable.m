function output = generateTable(n)
	
	for i=1:n
		a = floor(rand() * 100) / 100;
		toSort(i) = a;		
	end

	

	
	table = sort(toSort);

	table(n+1) = 1.00;
	for i=1:n+1
		printf('%.2f\n', table(i));
	end

	for i=1:n+1
		if (i == 1)
			printf('%3d, %.2f, %.2f, %3d-%3d\n', i, table(i), table(i), 1, floor(table(i) * 100));
		else
			printf('%3d, %.2f, %.2f, %3d-%3d\n', i, table(i), table(i) - table(i-1), floor(table(i-1) * 100) + 1, floor(table(i) * 100));

		end
	end 

	output = table;