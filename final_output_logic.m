function output = final_output_logic(rng_inter_arrival_time,rng_service_time,interarrival,counter1,counter2,temperature,max_customer_no)

    customer_no = [1:length(rng_service_time)];
    interarrival_time = [];
    arrival_time = [0];
    waiting_time = [];
    time_entering = [0];
    time_spent= [];
    serve_history = [];
    serve_history1 = 0;
    serve_history2 = 0;
    used_index = [];
    customer_in_center = [0];
    isCounter1 = 1;
    
    time_begins1 = [];
    service_time1 = [];
    service_time_end1=[];
    combined_service_time_end = [];
    time_begins2 = [];
    service_time2 = [];
    service_time_end2=[];
    min_service_end_index = 0;
    
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
            
        
            customer_in_center(i) = temp_customer_in_center;
            
            if max_customer_no - customer_in_center(i) <= 0 & temperature(i) < 37.5
                min_service_end = 1000000;
                % get the earliest customer to leave
                for j = 1: i-1
                    if combined_service_time_end(j) == -1 | combined_service_time_end(j) - arrival_time(i) <= 0
                        continue;
                    end
                    temp_used = 0;
                    for k = 1 : length(used_index)
                        if j == used_index(k)
                            temp_used = 1;
                            break;
                        end
                    end
                    if temp_used
                        continue;
                    end
                    if combined_service_time_end(j) <= min_service_end
                        min_service_end = combined_service_time_end(j);
                        min_service_end_index = j;
                    end
                end
                time_entering(i) = min_service_end;
                used_index(:, length(used_index) + 1) = min_service_end_index;
            else
                time_entering(i) = arrival_time(i);
            end
            %check which counter to go next
            if temperature(i) < 37.5
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
            
            combined_service_time_end(i) = -1;
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
            combined_service_time_end(i) = service_time_end1(i);
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
            combined_service_time_end(i) = service_time_end2(i);
        end
    end
    
    %for ( i = 1:length(customer_no))
    %    printf('%d      %d      %d      %d      %d      %d      %d\n', customer_no(i), temperature(i), rng_inter_arrival_time(i), interarrival_time(i), arrival_time(i), customer_in_center(i), time_entering(i));
    %end
    %printf('\n');
    %for ( i = 1:length(customer_no))
    %   printf('%d      %d      %d      %d      %d      %d      %d      %d      %d      %d\n', customer_no(i), rng_service_time(i), service_time1(i), time_begins1(i), service_time_end1(i), service_time2(i), time_begins2(i), service_time_end2(i), waiting_time(i), time_spent(i));
    %end
    
    %for  i = 1 : length(used_index)
    %    printf('%d\n', used_index(i));
    %end
    
  output = {{customer_no, temperature, rng_inter_arrival_time, interarrival_time, arrival_time, customer_in_center, time_entering},{customer_no, rng_service_time, service_time1, time_begins1, service_time_end1, service_time2, time_begins2, service_time_end2, waiting_time, time_spent}};
