function dropoff_point = energy_dropoff(energy_history,threshold)
    dropoff_point = 0;
    for i = 1:length(energy_history)
        if energy_history(i) < threshold*energy_history(1)
            dropoff_point = i;
            break;
        end
    end
end