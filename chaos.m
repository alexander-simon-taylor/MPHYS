function logged_axes = chaos(diff_history,iterations,number,ds,seperate)
    diff_history(:,:,1) = [];
    diff_history = permute(diff_history,[1 3 2]);
    distHistory = zeros(number,iterations - 1);
    for i = 1:number
        distHistory(i,:,:) = vecnorm(diff_history(i,:,:),2,3);
    end
    clear('diff_history');
    avgHistory = mean(distHistory,2);
    minusMean = distHistory - avgHistory;
    variance = sum(minusMean'.^2)/(iterations - 1);
    logged_variance = log10(variance);
    logged_path = log10(1:number) + log10(ds);
    if seperate == 0
        logged_axes = [logged_path(floor(10/ds):end);logged_variance(floor(10/ds):end)]';
    else
        logged_axes = logged_variance;
    end
end