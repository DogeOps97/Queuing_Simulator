function output = random_lcg()
    output = mod(mod(3472989573 * randi(1, 1000000) + 1, 2^32), 100);
    % anonymous function method:
    % lcg = @(m,a,c,x) mod(a * x + c, m)
 
    
    