function rr = find_rr(res, chk_dat)
%calculate r^2 according to given formula
    mean_data = mean(chk_dat);
    ss_res = sum( (chk_dat - res) .^ 2 );
    ss_tot = sum( (chk_dat - mean_data) .^ 2 );
    rr = 1 - ss_res / ss_tot;
end