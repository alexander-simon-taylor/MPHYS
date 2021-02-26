function chaotic_check = lyapunov(diff_history,number,iterations)
    runthrough = 2;
    max_product = 0;
    while max_product <= 1 & runthrough <= iterations
        product = ones(3,1);
        for j = 1:number
            product = product.*diff_history(j,:,runthrough).^(1/number);
        end
        max_product = max(product);
        runthrough = runthrough + 1;
    end
    if max_product > 1
        chaotic_check = 1;
    else
        chaotic_check = 0;
    end
end