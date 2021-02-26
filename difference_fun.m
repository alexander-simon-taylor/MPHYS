function distances = difference_fun(slice,particle_slice)
    common_points = min(size(slice,1),size(particle_slice,1));
    vector_difference = slice(1:common_points,:) - particle_slice(1:common_points,:);
    distances = sqrt(vector_difference(:,1).^2 + vector_difference(:,2).^2);
end