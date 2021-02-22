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
    got_event = 1;
    for ( i = 0: last)
        for( j = 1 : totalCustomer)
            if i - arrival_time(j) < 0
                break;
            end
            
            % customer cannot enter due to high temperature
            if time_entering(j) == -1 & arrival_time(j) == i 
                printf('Customer %d arrived at minute %d and was not allowed to enter the centre due to high temperature.\n', j, arrival_time(j));
                got_event = 1;
            end
            
            % customer have to wait outside due to full max customer
            if time_entering(j) ~= -1 &  arrival_time(j) == i & arrival_time(j)~= time_entering(j)
                printf('Customer %d arrived at minute %d and have to wait outside due to maximum customer.\n', j, arrival_time(j));
                got_event = 1;
            end
            
            %customer waiting outside entering the store
            if time_entering(j) ~= -1 &  time_entering(j) == i & arrival_time(j)~= time_entering(j)
                printf('Customer %d can finally go in the center at minute %d.\n', j, time_entering(j));
                got_event = 1;
            end
            
            % customer allowed to enter center
            if time_entering(j) ~= -1 & arrival_time(j) == i &  time_entering(j) == arrival_time(j)
                printf('Customer %d arrived at minute %d and entered the center at minute %d.\n', j, arrival_time(j), time_entering(j));
                got_event = 1;
            end
            
            %see if customer come out
            if service_time_end_1(j) == i
                printf('Departure of Customer %d minute %d.\n', j, service_time_end_1(j));
                got_event = 1;
            end

            if service_time_end_2(j) == i
                printf('Departure of Customer %d minute %d.\n', j, service_time_end_2(j));
                got_event = 1;
            end
        end
        
        if got_event
            printf('\n');
            got_event = 0;
        end
    end