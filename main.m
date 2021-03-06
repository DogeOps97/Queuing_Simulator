function output = main()

    disp(' ');

    printf('1 : Linear Congruential Generators\n');
    printf('2 : Random Variate Generator for Exponential Distribution\n');
    printf('3 : Random Variate Generator for Uniform Distribution\n');
    printf('4 : Mersenne Twister\n');

    disp(' ');
    
    % user input and error handling
    generatorType = input('Enter the choice for generator to use : ');
    while (generatorType > 4 | generatorType < 1)
        disp('type of generator must be in the option range');
        generatorType = input('Enter the choice for generator to use again: ');
    end
    totalCustomer = input('Enter total number of customers : ');
    while (totalCustomer <= 0)
        disp('Total customer must be a positive integer!');
        totalCustomer = input('Enter total number of customers again: ');
    end
    maxCustomer = input('Enter the maximum number of customers allowed in the center at the same time : ');
    while (maxCustomer < 2)
        disp('Maximum number of customer must be 2 or higher!');
         maxCustomer = input('Enter the maximum number of customers allowed in the center at the same time : ');
    end
    disp(' ');
    
    a = 36.0;
    b = 15;

    random_inter = random_gen(generatorType, totalCustomer);
    random_inter(1)  = -1;

    random_service = random_gen(generatorType, totalCustomer);

    random_temp = random_gaussian(totalCustomer, 36.5, 1.2);

    prob_inter = {[1:5];[sort(random_gen_nodupe(generatorType, 4)), 100]};
    prob_counter1 = {[5:9];[sort(random_gen_nodupe(generatorType, 4)), 100]};
    prob_counter2 = {[6:10];[sort(random_gen_nodupe(generatorType, 4)), 100]};

    printf('\n### Random Interarrival Time Values :\n');

    printf('( ');
    for(i=2:totalCustomer - 1)
        printf('%d, ', random_inter(i));
    end
    printf('%d )\n\n', random_inter(totalCustomer));

    disp('### Random Service Time Values :');

    printf('( ');
    for(i=1:totalCustomer - 1)
        printf('%d, ', random_service(i));
    end
    printf('%d )\n\n\n', random_service(totalCustomer));

    disp('######################');
    disp('# Interarrival Table #');
    disp('######################');
    printf('\n');

    disp('----------------------------------------------------------------------');
    disp('|  Interarrival  |  Probability  |      CDF      |   Random Number   |');
    disp('|      Time      |               |               |       Range       |');
    disp('----------------------------------------------------------------------');

    for(i=1:5)
        if(i == 1)
            printf('|%8d        |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', i, float(prob_inter{2}(i))/100, float(prob_inter{2}(i))/100, 0, prob_inter{2}(i));
        else
            printf('|%8d        |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', i, float(prob_inter{2}(i) - prob_inter{2}(i-1))/100, float(prob_inter{2}(i))/100, prob_inter{2}(i-1) + 1, prob_inter{2}(i));
        end
        disp('----------------------------------------------------------------------');
    end

    printf('\n\n');
    disp('###################');
    disp('# Counter 1 Table #');
    disp('###################');
    printf('\n');

    disp('---------------------------------------------------------------------');
    disp('|    Service    |  Probability  |      CDF      |   Random Number   |');
    disp('|     Time      |               |               |       Range       |');
    disp('---------------------------------------------------------------------');

    for(i=1:5)
        if(i == 1)
            printf('|%8d       |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', prob_counter1{1}(i), float(prob_counter1{2}(i))/100, float(prob_counter1{2}(i))/100, 0, prob_counter1{2}(i));
        else
            printf('|%8d       |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', prob_counter1{1}(i), float(prob_counter1{2}(i) - prob_counter1{2}(i-1))/100, float(prob_counter1{2}(i))/100, prob_counter1{2}(i-1) + 1, prob_counter1{2}(i));
        end
        disp('---------------------------------------------------------------------');
    end

    printf('\n\n');


    disp('###################');
    disp('# Counter 2 Table #');
    disp('###################');
    printf('\n');

    disp('---------------------------------------------------------------------');
    disp('|    Service    |  Probability  |      CDF      |   Random Number   |');
    disp('|     Time      |               |               |       Range       |');
    disp('---------------------------------------------------------------------');

    for(i=1:5)
        if(i == 1)
            printf('|%8d       |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', prob_counter2{1}(i), float(prob_counter2{2}(i))/100, float(prob_counter2{2}(i))/100, 0, prob_counter2{2}(i));
        else
            printf('|%8d       |    %6.2f     |    %6.2f     |  %6d - %-6d  |\n', prob_counter2{1}(i), float(prob_counter2{2}(i) - prob_counter2{2}(i-1))/100, float(prob_counter2{2}(i))/100, prob_counter2{2}(i-1) + 1, prob_counter2{2}(i));
        end
        disp('---------------------------------------------------------------------');
    end

    final_output = final_output_logic(random_inter, random_service, prob_inter, prob_counter2, prob_counter2, random_temp, maxCustomer);

    printf('\n\n')

    disp('######################');
    disp('# Main Output Tables #');
    disp('######################');

    disp('------------------------------------------------------------------------------------------------------------------------------------');
    disp('|  Customer  |  Temperature  |      Random       |   Inter-arrival   |    Arrival    |   Number of customers   |   Time entering   |');
    disp('|   number   |   (Celsius)   |    number for     |        time       |      time     |       in the center     |     the center    |');
    disp('|            |               |   inter-arrival   |                   |               |                         |                   |');
    disp('|            |               |       time        |                   |               |                         |                   |');
    disp('------------------------------------------------------------------------------------------------------------------------------------');

    for i=1 : totalCustomer    
        if i == 1 % first row interarrival time is '-'
            if (final_output{1}{2}(i) >= 37.5)
                printf('|%6d      |  %7.1f      |         -         |          -        |   %6d      |             -           |          -        |\n',  final_output{1}{1}(i), final_output{1}{2}(i),  final_output{1}{5}(i));
            else
                printf('|%6d      |  %7.1f      |         -         |          -        |   %6d      |        %6d           |     %6d        |\n',  final_output{1}{1}(i), final_output{1}{2}(i),  final_output{1}{5}(i),  final_output{1}{6}(i),  final_output{1}{7}(i));      
            end
        else
            if (final_output{1}{2}(i) >= 37.5)
                printf('|%6d      |  %7.1f      |     %6d        |     %6d        |   %6d      |             -           |          -        |\n',  final_output{1}{1}(i),  final_output{1}{2}(i),  final_output{1}{3}(i),  final_output{1}{4}(i),  final_output{1}{5}(i));
            else
                printf('|%6d      |  %7.1f      |     %6d        |     %6d        |   %6d      |        %6d           |     %6d        |\n',  final_output{1}{1}(i),  final_output{1}{2}(i),  final_output{1}{3}(i),  final_output{1}{4}(i),  final_output{1}{5}(i),  final_output{1}{6}(i),  final_output{1}{7}(i));
            end
        end
        disp('------------------------------------------------------------------------------------------------------------------------------------');
    end;


    disp(' ');
    disp(' ');

    disp('-------------------------------------------------------------------------------------------------------------------------------------------------');
    disp('|  Customer  |    Random    |                   Counter 1                  |                   Counter 2                  |  Waiting  |  Time   |');
    disp('|   number   |  number for  |______________________________________________|______________________________________________|    time   |  spent  |');
    disp('|            |    service   |   Service  |  Time Service  |  Time Service  |   Service  |  Time Service  |  Time Service  |           |         |');
    disp('|            |     time     |     time   |      begins    |      ends      |     time   |      begins    |      ends      |           |         |');
    disp('-------------------------------------------------------------------------------------------------------------------------------------------------');


    for i=1 : totalCustomer   
        if (final_output{1}{2}(i) >= 37.5)
            printf('|%6d      |  %6d      |      -     |        -       |        -       |     -      |        -       |        -       |      -    |    -    |\n', final_output{2}{1}(i), final_output{2}{2}(i));
        else
            if final_output{2}{8}(i) == -1
                printf('|%6d      |  %6d      |    %3d     |  %7d       |      %3d       |            |                |                |    %3d    |  %3d    |\n', final_output{2}{1}(i), final_output{2}{2}(i), final_output{2}{3}(i), final_output{2}{4}(i), final_output{2}{5}(i), final_output{2}{9}(i), final_output{2}{10}(i));
            else
                printf('|%6d      |  %6d      |            |                |                |    %3d     |      %3d       |      %3d       |    %3d    |  %3d    |\n', final_output{2}{1}(i), final_output{2}{2}(i), final_output{2}{6}(i), final_output{2}{7}(i), final_output{2}{8}(i), final_output{2}{9}(i), final_output{2}{10}(i));
            end
        end
    disp('-------------------------------------------------------------------------------------------------------------------------------------------------');
    end;

    disp(' ');

    counter1_time = 0;
    counter2_time = 0;
    max_time = 0;
    queue_count = 0;
    queue_total = 0;

    for(i=1:totalCustomer)
        if(final_output{2}{3}(i) >= 1)
            counter1_time = counter1_time + final_output{2}{3}(i);
        elseif(final_output{2}{6}(i) >= 1)
            counter2_time = counter2_time + final_output{2}{6}(i);
        end

        if(final_output{2}{5}(i) > max_time)
            max_time = final_output{2}{5}(i);
        elseif(final_output{2}{8}(i) > max_time)
            max_time = final_output{2}{8}(i);
        end

        if(final_output{2}{9}(i) > 0)
            queue_count = queue_count + 1;
            queue_total = queue_total + final_output{2}{9}(i);
        end
    end

    
    disp('######################');
    disp('#   Activities Logs  #');
    disp('######################');
    message_exhibition(totalCustomer, final_output{2}{5}, final_output{2}{8}, final_output{1}{5}, final_output{1}{2}, final_output{1}{7});
    printf('\n');
    disp('######################');
    disp('#     Statistics     #');
    disp('######################');
    printf('Percentage of time Counter 1 was busy : %.2f %%\n', (counter1_time/max_time) * 100);
    printf('Percentage of time Counter 2 was busy : %.2f %%\n', (counter2_time/max_time) * 100);
    printf('Probability of a customer having to wait in queue : %.2f\n', queue_count/totalCustomer);
    printf('Average waiting time in queue : %.2f\n', queue_total/totalCustomer);

    
    
    
    
    
    
    