random_interarrival = ['-', 26, 98, 90, 26, 42, 74, 80, 68, 22, 48, 34]
random_service = [95, 21, 51, 92, 89, 38, 13, 61, 50, 49, 39, 53]

num_cust = 12

interarrival_table = [[1, 25],
                      [2, 65],
                      [3, 85],
                      [4, 100]]

ali_table = [[2, 30],
             [3, 58],
             [4, 83],
             [5, 100]]

ahmad_table = [[3, 35],
               [4, 60],
               [5, 80],
               [6, 100]]

results = []

interarrival_time = '-'
arrival_time = 0
max_ali = 0
max_ahmad = 0

for customer in range(num_cust):
    ali_begin_service = ''
    ali_service_time = ''
    ali_service_end = ''
    ahmad_begin_service = ''
    ahmad_service_time = ''
    ahmad_service_end = ''
    time_in_queue = 0
    next_waiter = 0

    if customer != 0:
        for i in interarrival_table:
            if i[1] >= random_interarrival[customer]:
                interarrival_time = i[0]
                break
        arrival_time += interarrival_time

        # Check the service time end for each waiter
        for i in results:
            if type(i[7]) == int and i[7] > max_ali:
                max_ali = i[7]
            if type(i[10]) == int and i[10] > max_ahmad:
                max_ahmad = i[10]
        
        # If customer has to queue
        if arrival_time < max_ali and arrival_time < max_ahmad:
            if max_ali <= max_ahmad:
                next_waiter = 1
                time_in_queue = max_ali - arrival_time
            else:
                time_in_queue = max_ahmad - arrival_time
    
    # Ali is next server
    if max_ali <= arrival_time or next_waiter == 1:
        ali_begin_service = arrival_time + time_in_queue
        for i in ali_table:
            if i[1] >= random_service[customer]:
                ali_service_time = i[0]
                break
        ali_service_end = ali_begin_service + ali_service_time

    # Ahmad is next server
    else:
        ahmad_begin_service = arrival_time + time_in_queue
        for i in ahmad_table:
            if i[1] >= random_service[customer]:
                ahmad_service_time = i[0]
                break
        ahmad_service_end = ahmad_begin_service + ahmad_service_time

    results.append([customer + 1,
                    random_interarrival[customer],
                    interarrival_time,
                    arrival_time,
                    random_service[customer],
                    ali_begin_service,
                    ali_service_time,
                    ali_service_end,
                    ahmad_begin_service,
                    ahmad_service_time,
                    ahmad_service_end,
                    time_in_queue
                    ])

print('\n'.join(map(str, results))) 