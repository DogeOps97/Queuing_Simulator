function output = main()

    disp(' ');

    printf('1 : Linear Congruential Generators\n');
    printf('2 : Random Variate Generator for Exponential Distribution\n');
    printf('3 : Random Variate Generator for Uniform Distribution\n');

    disp(' ');

    generatorType = input('Enter the choice for generator to use : ');
    totalCustomer = input('Enter total number of customers : ');
    maxCustomer = input('Enter the maximum number of customers that are allowed to be in the center : ');
    
    disp(' ');
    
    final_output = final_output_logic2();
    
    a = 36.0;
    b = 15;

    disp('------------------------------------------------------------------------------------------------------------------------------------');
    disp('|  Customer  |  Temperature  |      Random       |   Inter-arrival   |    Arrival    |   Number of customers   |   Time entering   |');
    disp('|   number   |   (Celsius)   |    number for     |        time       |      time     |       in the center     |     the center    |');
    disp('|            |               |   inter-arrival   |                   |               |                         |                   |');
    disp('|            |               |       time        |                   |               |                         |                   |');
    disp('------------------------------------------------------------------------------------------------------------------------------------');

    for i=1 : totalCustomer    
        if i == 1 % first row interarrival time is '-'
            if (final_output{1}{2}(i) < 35 | final_output{1}{2}(i) > 37)
                printf('|%6d      |  %7.1f      |         -         |          -        |   %6d      |             -           |          -        |\n',  final_output{1}{1}(i), final_output{1}{2}(i),  final_output{1}{5}(i));
            else
                printf('|%6d      |  %7.1f      |         -         |          -        |   %6d      |        %6d           |     %6d        |\n',  final_output{1}{1}(i), final_output{1}{2}(i),  final_output{1}{5}(i),  final_output{1}{6}(i),  final_output{1}{7}(i));      
            end
        else
            if (final_output{1}{2}(i) < 35 | final_output{1}{2}(i) > 37)
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
        if (final_output{1}{2}(i) < 35 | final_output{1}{2}(i) > 37)
            printf('|%6d      |  %6d      |      -     |        -       |        -       |     -      |        -       |        -       |     -     |    -    |\n', final_output{2}{1}(i), final_output{2}{2}(i));
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

