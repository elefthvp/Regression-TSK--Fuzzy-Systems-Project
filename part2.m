%Eleftheria Papaioannou AEM:8566
%Fuzzy Systems, exercise 3 part 2

clear all;
close all;
warning('off','all')
load superconduct.csv
data=superconduct;

M = max(size(data));
inputs=min(size(data))-1;

%normalization
for i = 1:M
    max_data = max(data(i, 1:end-1));
    min_data = min(data(i, 1:end-1));
    dif = max_data-min_data;
    data(i, 1:end-1) = (data(i, 1:end-1) - min_data) /dif;
end


[trainInd,valInd,testInd] = dividerand(20867,0.6,0.2,0.2);
a = randperm(length(trainInd));
b = randperm(length(valInd));
c = randperm(length(testInd)); 


trn = data(a,:);
val = data(b,:);
chk = data(c,:);

NF = [3 8 12 15];
NR = [3 6 9 12 15];


[trn_dim_M, trn_dim_N] = size(trn);
cv = cvpartition(trn_dim_M, 'KFold', 5);
positions = 1:length(trn);


mean_err_mtrx = zeros(4, 5);


[ranks, weights] = relieff(trn(:, 1:end-1), trn(:, end), 40);



optimal = {};

 for f = 1:length(NF)
     for r = 1:length(NR)

        features = ranks(1:NF(f));
        features = [features inputs+1];
        optimal{f, r} = features;

        for j = 1:5
            [row, col, v_80] = find(positions.*(~cv.test(j))'); 
            %% ektos tou 20% 
            [row, col, v_20] = find(positions.*(cv.test(j))'); % 20 %
            trn_80 = trn(v_80, :);
            v_20 = trn(v_20, :);

            trn_new = trn_80(:, features);
            v_new = v_20(:, features);
             
            inFIS = genfis3(trn_new(:,1:end-1),trn_new(:,end),'sugeno',NR(r),opt);

            [fis,error,stepsize,finalfis,chkerror] = anfis(trn_new,inFIS,100,[0 0 0 0],v_new);
            mean_err_mtrx(f, r) = mean_err_mtrx(f,r) + min(chkerror);
        end
         fprintf('Feature index %d Rule index %d [DONE].\n', NF(f), NR(r)); 
     end
 end

[i_min,j_min]=minmat(mean_err_mtrx);

feat = NF(i_min);
rules = NR(j_min);
features = optimal{i_min,j_min};


trn_new = trn(:, features);
val_new = val(:, features);
chk_new = chk(:, features);

opt = NaN(4,1);
opt(4) = 0;

fismat = genfis3(trn_new(:, 1:end-1),trn_new(:,end),'sugeno',rules,opt);
[FIS,ERROR,STEPSIZE,FINALFIS,CHKERROR]=anfis(trn_new,fismat,300,[0 0 0],val_new);

result = evalfis(chk_new(:,1:end-1),FINALFIS);

%calculate metrics
mse=find_mse(result, chk_new(:, 5));
rr =find_rr(result, chk_new(:, 5));
nmse=find_nmse(result, chk_new(:, 5));
ndei=find_ndei(nmse);

%learning curves.
figure()
plot(ERROR, 'LineWidth',1.5)
hold on
plot(CHKERROR, 'LineWidth', 1.5)
legend('Training', 'Check')




