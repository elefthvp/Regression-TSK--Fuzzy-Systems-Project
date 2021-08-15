function nmse = find_nmse(res, chk_dat)
%calculate nmse according to given formula
    mean_data = mean(chk_dat);
    num = length(chk_dat);
    nmse = (sum( (chk_dat - res) .^ 2 ) / num) /  (sum( (chk_dat - mean_data) .^ 2 ) / num);
end