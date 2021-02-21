function output = final_output_logic2(rng_inter_arrival_time,rng_service_time,interarrival,counter1,counter2,temperature,max_customer_no)
    %test datas
    %rng_inter_arrival_time = [-1 26 98 90 26 42 74 80 68 22 48 34];
    %rng_service_time = [95 21 51 92 89 38 13 61 50 49 39 53];
    %interarrival={[1 2 3 4], [25 65 85 100]};
    %counter1 = {[2 3 4 5], [30 58 83 100]};
    %counter2 = {[3 4 5 6], [35 60 80 100]};
    %temperature = MersenneTwisterInt(1,34,40,total_customer);
    %temperature = [36 36 36 36 36 36 36 36 36 36 36 36];
    %max_customer_no = 2;

    customer_no = [1:length(rng_service_time)];
    total_customer = length(customer_no);
    
    interarrival_time = [];
    arrival_time = [0];
    waiting_time = [];
    time_entering = [0];
    time_spent= [];
    serve_history = [];
    serve_history1 = 0;
    serve_history2 = 0;
    customer_in_center = [];
    isCounter1 = 1;
    
    %{[time_begins], [service_time], [time_service_ends]}
    time_begins1 = [];
    service_time1 = [];
    service_time_end1=[];
    
    time_begins2 = [];
    service_time2 = [];
    service_time_end2=[];
    prev_customer_index = 0;
    
    %make sure got first case
    got_first = 0;
    
    %Main Loop
    for i=1:length(rng_service_time)
        if ~got_first % if all counter free
            interarrival_time(i) = -1;
            time_in_queue(i) = 0;
            got_first = 1;
        else
            
            interarrival_time(i) = getInterArrivalTime(interarrival, rng_inter_arrival_time(i));
            arrival_time(i) = arrival_time(i-1) + interarrival_time(i);
            
            %check got how many ppl in the center before
            temp_customer_in_center = 0;
            end_of_loop = 0;
            min_service_end = 0;
            temp_min_service_end_1 = 0;
            temp_min_service_end_2 = 0;
            for j = i - 1: -1 : 1
                %if serve_history is obsolte (cause of temperature)
                if serve_history(j) == -1
                    continue;
                end
                if serve_history(j)
                    if (service_time_end1(j) ~= -1) & (service_time_end1(j) - arrival_time(i) > 0)
                        temp_customer_in_center = temp_customer_in_center + 1;
                        temp_min_service_end_1 = service_time_end1(j);
                    else
                        end_of_loop = end_of_loop + 1;
                    end
                else
                    if (service_time_end2(j) ~= -1) & (service_time_end2(j) - arrival_time(i) > 0)
                        temp_customer_in_center = temp_customer_in_center + 1;
                        temp_min_service_end_2 = service_time_end2(j);
                    else
                        end_of_loop = end_of_loop + 1;
                    end
                end
                if end_of_loop == 2
                    break;
                end
            end
            
            % get the earliest customer to leave
            if temp_min_service_end_1 < temp_min_service_end_2
                min_service_end = temp_min_service_end_1;
            else
                min_service_end = temp_min_service_end_2;
            end
            customer_in_center(i) = temp_customer_in_center;
            
            if max_customer_no - customer_in_center(i) <= 0
                time_entering(i) = min_service_end;
            else
                time_entering(i) = arrival_time(i);
            end
            %check which counter to go next
            if serve_history1 <= serve_history2
                isCounter1 = 1;
            else
                if serve_history1  - arrival_time(i)<= 0
                    isCounter1 = 1;
                else
                    isCounter1 = 0;
                end
            end
                
        end
        if (temperature(i) >= 37.5)
            customer_in_center(i) = -1;
            time_entering(i) = -1;
            time_begins1(i) = -1;
            service_time1(i) = -1;
            service_time_end1(i) = -1;
            
            time_begins2(i) = -1;
            service_time2(i) = -1;
            service_time_end2(i) = -1;
            waiting_time(i) = -1;
            time_spent(i) = -1;
            serve_history(i) = -1;
            continue;
        end
        if isCounter1
            if serve_history1 == 0 % first time using counter 1
                time_begins1(i) = arrival_time(i);
            else
                if serve_history1 - arrival_time(i) >= 0 
                    time_begins1(i) = serve_history1;
                else
                    time_begins1(i) = arrival_time(i);
                end
            end
            time_begins2(i) = -1;
            service_time2(i) = -1;
            service_time_end2(i) = -1;
            
            service_time1(i) = getServiceTime(counter1, rng_service_time(i));
            service_time_end1(i) = time_begins1(i) + service_time1(i);
            waiting_time(i) = time_begins1(i) - arrival_time(i);
            time_spent(i) = service_time_end1(i) - arrival_time(i);
            serve_history(i) = 1;
            serve_history1 = service_time_end1(i);
        else
            if serve_history2 == 0 % first time using counter 2
                time_begins2(i) = arrival_time(i);
            else
                if serve_history2 - arrival_time(i) >= 0 
                    time_begins2(i) = serve_history2;
                else
                    time_begins2(i) = arrival_time(i);
                end
            end
            time_begins1(i) = -1;
            service_time1(i) = -1;
            service_time_end1(i) = -1;
            
            service_time2(i) = getServiceTime(counter2, rng_service_time(i));
            service_time_end2(i) = time_begins2(i) + service_time2(i);
            waiting_time(i) = time_begins2(i) - arrival_time(i);
            time_spent(i) = service_time_end2(i) - arrival_time(i);
            serve_history(i) = 0;
            serve_history2 = service_time_end2(i);
        end
    end
    
    %for ( i = 1:length(customer_no))
    %    printf('%d      %d      %d      %d      %d      %d      %d\n', customer_no(i), temperature(i), rng_inter_arrival_time(i), interarrival_time(i), arrival_time(i), customer_in_center(i), time_entering(i));
    %end
    %printf('\n');
    %for ( i = 1:length(customer_no))
    %   printf('%d      %d      %d      %d      %d      %d      %d      %d      %d      %d\n', customer_no(i), rng_service_time(i), service_time1(i), time_begins1(i), service_time_end1(i), service_time2(i), time_begins2(i), service_time_end2(i), waiting_time(i), time_spent(i));
    %end
    
%    for  i = 1 : length(time_entering)
%        printf('%d\n', time_entering(i));
%    end
    
  output = {{customer_no, temperature, rng_inter_arrival_time, interarrival_time, arrival_time, customer_in_center, time_entering},{customer_no, rng_service_time, service_time1, time_begins1, service_time_end1, service_time2, time_begins2, service_time_end2, waiting_time, time_spent}};
