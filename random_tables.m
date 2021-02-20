function output = random_tables(choice, num_cust)

    random_inter = random_gen(choice, num_cust);
    random_inter(1)  = -1;

    random_service = random_gen(choice, num_cust);

    random_temp = random_gaussian(num_cust, 36.5, 1.2);

    prob_inter = {[1:5];[sort(random_gen_nodupe(choice, 4)), 100]};
    prob_counter1 = {[1:5];[sort(random_gen_nodupe(choice, 4)), 100]};
    prob_counter2 = {[1:5];[sort(random_gen_nodupe(choice, 4)), 100]};
    prob_inter{2}
    