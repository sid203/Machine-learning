function [C, sigma] = dataset3Params(X, y, Xval, yval)
% returns the values of C and sigma for which errors on validations set are
% minimum 
C = 0.001;
sigma = 0.01;
val=[0.01 0.03 0.1 0.3 1 3 10 30];
for i=1:8
    C=val(i);
    for j=1:8
        sigma=val(j);
        model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
        predictions=svmPredict(model,Xval);
        err(i,j)=mean(double(predictions ~= yval));
    end
end
for m=1:8
    for n=1:8
        if(err(m,n)==min(min(err)))
            C=val(m);
            sigma=val(n);
        end
    end
end
end
