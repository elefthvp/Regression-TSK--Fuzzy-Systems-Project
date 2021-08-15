%Eleftheria Papaioannou AEM:8566
%Fuzzy Systems, exercise 3 part 1

clear;
close all;

load CCPP.dat


[trainInd,valInd,testInd] = dividerand(9568,0.6,0.2,0.2);
a=randperm(length(trainInd));
b=randperm(length(valInd));
c=randperm(length(testInd)); 


trn = CCPP(a,:);
val = CCPP(b,:);
chk = CCPP(c,:);


num_of_mf=[2 3 2 3];
type_of_mf = 'gbellmf';


%singleton -> constant, %polynomial->linear
tsk(1) = genfis1(trn, num_of_mf(1), type_of_mf, 'constant');
tsk(2) = genfis1(trn, num_of_mf(2), type_of_mf, 'constant');
tsk(3) = genfis1(trn, num_of_mf(3), type_of_mf, 'linear');
tsk(4) = genfis1(trn, num_of_mf(4), type_of_mf, 'linear');



count_figures=0;
for i=1:4 
%i=4
    
    [fis,error,stepsize,chkFis,chkErr] = ...
     anfis(trn, tsk(i), [100, 0], 0, val);
    result = evalfis(chk(:,1:4), chkFis);
    mse(i)=0;
    mse(i)=find_mse(result, chk(:, 5));
    rr(i)=0;
    rr(i) =find_rr(result, chk(:, 5));
    nmse(i)=0;
    nmse(i)=find_nmse(result, chk(:, 5));
    ndei(i)=0;
    ndei(i)=find_ndei(nmse(i));
    
    %%plot member functions
   

count_figures=count_figures+1
fig(count_figures)=figure();
plot(error, 'LineWidth',2)
hold on
plot(chkErr, 'LineWidth',2)
title(['Learning curves, ' num2str(num_of_mf(i)) ' member functions, ' 'Singleton'])
legend('Train', 'Check')
hold off


% Plot the prediction error.
count_figures=count_figures+1
fig(count_figures)=figure();
predict_error =  chk(:, 5) - result;
plot(predict_error, 'LineWidth',2)
xlabel('n')
ylabel('error')
title(['Prediction Error: ' num2str(num_of_mf(i)) ' MFs, ' 'Polynomial'])
   
end
