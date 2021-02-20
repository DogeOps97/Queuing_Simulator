function output = final_output_logic()
    %test datas
    rng_inter_arrival_time = [-1 26 98 90 26 42 74 80 68 22 48 34];
    rng_service_time = [95 21 51 92 89 38 13 61 50 49 39 53];
    interarrival={[1 2 3 4], [25 65 85 100]};
    counter1 = {[2:5], [30 58 83 100]};
    counter2 = {[3:6], [35 60 80 100]};
    
    %queue opertaion, c(:,1) = []--> remove first index, c(:,length(c)+1) = 2 --> add to last index
    queue1 = [];
    queue2 = [];
    
    interarrival_time = [];
    arrival_time = [];
    %{[time_begins], [service_time], [time_service_ends]}
    output_counter1={[],[],[]};
    output_counter2={[],[],[]};
    time_in_queue = [];
    customer_no = [1:length(rng_service_time)];
    isCounter1 = 1;
    timeSpent= [];
    serviceCounter = [];
    %get who is in which queue
    
    
    %Main Loop
    for i=1:length(rng_service_time)
        printf('1');
        if i == 1
            interarrival_time(i) = -1;
            arrival_time(i) = 0;
            time_in_queue(i) = 0;
        else
            interarrival_time(i) = getInterArrivalTime(interarrival, rng_inter_arrival_time(i));
            arrival_time(i) = arrival_time(i-1) + interarrival_time(i);
            num_of_queue1 = 0;
            num_of_queue2 = 0;
            end_of_loop = 0;
            for j=i-1:-1:1
                if serviceCounter(j) == 1 %if its counter 1
                    if output_counter1 {3}(j) -  arrival_time(i) > 0
                        num_of_queue1 = num_of_queue1 + 1;
                    else
                        end_of_loop = end_of_loop+1;
                    end;
                else
                    if output_counter2 {3}(j) -  arrival_time(i) > 0
                        num_of_queue2 = num_of_queue1 + 1;
                    else
                        end_of_loop = end_of_loop+1;
                    end
                end
                if end_of_loop == 2 %more efficient UWU
                    break;
                end
            end
            if (num_of_queue1 - num_of_queue2) <= 0
                isCounter1 = 1;
            else
                isCounter1 = 0;
            end
                    
        end
        if isCounter1 == 1      
            % set interarrival times, arrival time and time in queue
            if i == 1
                output_counter1{1}(i) = 0; % assign the first time service begin in 0
                %get the time in queue
                time_in_queue(i) = 0;
                    
            else
                time_in_queue(i) = 0;
                for j = i-1:-1:1
                        if output_counter1{3}(j) ~= -1 
                            if arrival_time(i) - output_counter1{3}(j)< 0
                                time_in_queue(i) =  output_counter1{3}(j)- arrival_time(i);
                                output_counter1{1}(i) =  output_counter1{3}(j);
                            else
                                output_counter1{1}(i) = arrival_time(i);
                            end
                            break;
                        end
                end
            end
            
            % set details for counter 2 at the specific index -1 to state empty
            output_counter2{1}(i) = -1;
            output_counter2{2}(i) = -1;
            output_counter2{3}(i) = -1;
            
            % set details for counter 1
            % set service time start
            
            
            % set service time
            output_counter1{2}(i) = getServiceTime(counter1, rng_service_time(i));
            % set service time end
            output_counter1{3}(i) = output_counter1{1}(i) + output_counter1{2}(i);
            
            %set time spent
            timeSpent(i) =  output_counter1{3}(i) -  output_counter1{1}(i) + time_in_queue(i);
            serviceCounter(i) = 1;
        else
            time_in_queue(i) = 0;
            for j = i-1:-1:1
                    if output_counter2{3}(j) ~= -1 
                        if arrival_time(i) - output_counter2{3}(j) < 0
                            time_in_queue(i) =  output_counter2{3}(j)- arrival_time(i);
                            output_counter2{1}(i) =  output_counter2{3}(j);
                        else
                            output_counter2{1}(i) = arrival_time(i);
                        end
                        break;
                    end
            end
            % set details for counter 1 at the specific index -1 to state empty
            output_counter1{1}(i) = -1;
            output_counter1{2}(i) = -1;
            output_counter1{3}(i) = -1;
            
            % set details for counter 2
            % set service time
            output_counter2{2}(i) = getServiceTime(counter2, rng_service_time(i));
            % set service time end
            output_counter2{3}(i) = output_counter2{1}(i) + output_counter2{2}(i);
            %set time spent
            timeSpent(i) =  output_counter2{3}(i) -  output_counter2{1}(i) + time_in_queue(i);
            
            serviceCounter(i) = 0;
        end
    end
    output = 3;
% output = {{customer_no, rng_inter_arrival_time, interarrival_time, arrival_time},{rng_service_time,output_counter1{1}, output_counter1{2}, output_counter1{3}, output_counter2{1},output_counter2{2},output_counter2{3},time_in_queue, timeSpent}};