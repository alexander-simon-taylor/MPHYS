function tot_lengths = recurrence(history,ds,position,radius_recurrence,tot_lengths)
    displacement = mod(abs(history - position),2*pi);
    perm_displacement = permute(displacement,[1 3 2]);
    distance = zeros(size(history,1),size(history,3));
    for j = 1:size(history,1)
        distance(j,:) = vecnorm(perm_displacement(j,:,:),2,3);
    end
    clear('perm_displacement');
    for i = 1:size(history,3)
        index = find(distance(:,i) < radius_recurrence);
        lengths = ds*diff(index(find(diff(index) > 1)));
        tot_lengths = [tot_lengths,lengths'];
    end
end