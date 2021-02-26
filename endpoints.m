function endpoint_points = endpoints(history)
    perm_hist = permute(history,[3,2,1]);
    endpoint_points = perm_hist(:,:,end);
end