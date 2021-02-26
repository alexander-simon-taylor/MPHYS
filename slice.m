function poincare = slice(history,num_colours,number)
    fraction = floor(number/num_colours);
    history_colours = zeros(fraction,3,num_colours);
    poincare = {};
    for i = 1:num_colours
        history_colours(:,:,i) = history((i - 1)*fraction + 1:i*fraction,:);
        region = round((history_colours(:,3,i)+ pi)./(2*pi));
        integerPart = round((history_colours(:,3,i))./(2*pi));
        lowerSpecialIndex = find(diff(region));
        upperSpecialIndex = lowerSpecialIndex + 1;
        special = (history_colours(lowerSpecialIndex,1:2,i) - ...
            history_colours(upperSpecialIndex,1:2,i))./(history_colours(lowerSpecialIndex-1,3,i) - ...
            history_colours(upperSpecialIndex,3,i)).*(2*pi*integerPart(upperSpecialIndex) - ...
            history_colours(upperSpecialIndex,3,i)) + history_colours(upperSpecialIndex,1:2,i);
        special = mod(special,2*pi)./(2*pi);
        poincare{end + 1} = special;
    end
end