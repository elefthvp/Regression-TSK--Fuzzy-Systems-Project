function mse = find_mse(res, chk_dat)
    %calculate mse according to given formula
    num = length(res);
    mse = sum((res - chk_dat) .^ 2) / num;
end