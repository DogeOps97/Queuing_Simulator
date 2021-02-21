function output = message_exhibition(totalCustomer, service_time_end_1, service_time_end_2, arrival_time, temperature, time_entering)
    
    % get the last time
    end_of_loop = 0;
    latest1 = 0;
    latest2 = 0;
    last = 0;
    % get the last maximum time
    for i = totalCustomer:-1: 1;
        % take the latest of counter 1
        if service_time_end_1(i) ~= -1 & latest1 == 0
            latest1 = service_time_end_1(i);
            end_of_loop = end_of_loop + 1;
        end
        if service_time_end_2(i) ~= -1 & latest2 == 0
            latest2 = service_time_end_2(i);
            end_of_loop = end_of_loop + 1;
        end
        if end_of_loop == 2
            break;
        end
    end
    if latest1 >= latest2
        last = latest1;
    else
        last = latest2;
    end
    
    % here it goes
    for ( i = 0: last)
        for( j = 1 : totalCustomer)
            if i - arrival_time(j) < 0 
                break;
            end
            
            if time_entering(j) == -1 & arrival_time(j) == i 
                printf('Customer %d arrived at minute %d and was not allowed to enter the centre\n', j, arrival_time(j));
            end

            if time_entering(j) ~= -1 & arrival_time(j) == i 
                printf('Customer %d arrived at minute %d and entered the centre at minute %d\n', j, arrival_time(j), time_entering(j));
            end
            
            if service_time_end_1(j) == i
                printf('Departure of customer %d minute %d\n', j, service_time_end_1(j));
            end

            if service_time_end_2(j) == i
                printf('Departure of customer %d minute %d\n', j, service_time_end_2(j));
            end
        end
    end