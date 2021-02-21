function output = getInterArrivalTime(interarrival, rng_number)
    interarrival_time = 0;
    for i=1:length(interarrival{2})
        if rng_number - interarrival{2}(i) <= 0
            interarrival_time = interarrival{1}(i);
            break;
        end
    end
    
    output = interarrival_time;