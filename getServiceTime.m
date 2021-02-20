function output = getServiceTime(counter, rng_number)
    service_time = 0;
    for i=1:length(counter{2})
        if rng_number - counter{2}(i) <= 0
            service_time = counter{1}(i);
            break;
        end
    end
    
    output = service_time;