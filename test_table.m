
intArrT = [0, 8, 8, 6, 3, 4, 4];
%ArrT(1) = 0;
ArrT = zeros(1, 4);

TimeEnter(1) = zeros(1, 4);
serviceTime = [4, 4, 4, 5, 4, 3, 1];


% -------------------------
% Set first row 
% -------------------------
ArrT(1) = 0;
timeServiceStart(1) = 0;
timeServiceEnds(1) = ArrT(1) + serviceTime(1);
timeSpentInSystem(1) = timeServiceEnds(1) - ArrT(1);
waitingTime(1) = timeServiceStart(1) - ArrT(1);

% end ---------------------
printf('%s\n', 'Before loop');

for (i = 1:length(ArrT))
    printf('%d ', ArrT(i));
end
printf('\n');

for i = 2:length(intArrT)
    printf('%d\n', i);
    printf('%s\n', 'Arrival time');
    ArrT(i) = ArrT(i-1) + intArrT(i);
    printf('%s\n', 'Get service start');
    TimeEnter(i) = ArrT(i);
    printf('%s - %d\n', 'Print time service ends', timeServiceEnds(i-1));
    printf('%s - %d\n', 'Print arrival time', ArrT(i));
    
    
    if (ArrT(i) >= timeServiceEnds(i-1))
        printf('%s\n', 'Arrive later than last service');
        timeServiceStart(i) = ArrT(i);
    else
        %ArrT(1) = 0;
        printf('%s\n', 'Arrive earlier than last service');
        timeServiceStart(i) = timeServiceEnds(i-1);
    end
    printf('%s\n', 'Retrieved service start');
    
    printf('%s - %d, %s - %d\n', 'Time service start', timeServiceStart(i), 'Arrival time - ', ArrT(i));
    waitingTime(i) = timeServiceStart(i) - ArrT(i);
    timeServiceEnds(i) = timeServiceStart(i) + serviceTime(i);
    timeSpentInSystem(i) = timeServiceEnds(i) - ArrT(i);
        
    
end
% fprintf('%2.0f %10.6f %10.6f %10.6f %10.6f %10.6f %10.6f\n', [i a(i) b(i) p(i) f(a(i)) f(p(i)) f(a(i))*f(p(i))]);
fprintf('%3s %3s %3s %3s %3s %3s %3s\n', 'int', 'arr', 'svT', 'TSB', 'TSE', 'WT', 'TIS');
for i = 1:length(intArrT)
    fprintf('%3d %3d %3d %3d %3d %3d %3d\n', intArrT(i), ArrT(i), serviceTime(i), timeServiceStart(i), timeServiceEnds(i), waitingTime(i), timeSpentInSystem(i)); 
end
    
    

