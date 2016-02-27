fprintf('Loading and Visualizing Data ...\n')

load('ex3data1.mat'); % training data stored in arrays X, y
X_copy=X;
y_copy=y;
X=X(1:3000,:);
Xval=X_copy(3001:5000,:);
y=y_copy(1:3000,:);
yval=y_copy(3001:5000,:);
m = size(X, 1);
num_labels = 10;
%m = length(y);% number of training examples
n = size(X, 2);
% You need to return the following variables correctly 
%all_theta = zeros(num_labels, n + 1);

% Add ones to the X data matrix
%X = [ones(m, 1) X];

theta=zeros(n+1,1);

error_train = zeros(10, 10);
error_val   = zeros(10, 10);
lambda=0.1;
J = 0;
display=zeros(100,2);
grad = zeros(size(theta));
c=zeros(100,401);
j=1;
for i=1:10

    [a b]=oneVsAll((X(1:300*i,:)), y(1:300*i), num_labels,lambda);
    %c(j:j+9,:)=a;
    %j=j+10;
    for j=1:10
        [J,grad]= lrCostFunction(a(j,:)',[ones(size(X(1:300*i,:),1),1) X(1:300*i,:)],(y(1:300*i)==j),0);
        error_train(i,j)=J;
        [error_val(i,j),gradw]= lrCostFunction(a(j,:)',[ones(size(Xval,1),1) Xval],(yval==j),0);
    end
    
    %[error_train(i) w]=lrCostFunction(b,(X(1:i,:)), y(1:i),0); 
end

plot(1/3000:300/3000:1, error_train(:,i), 1/3000:300/3000:1, error_val(:,i));
title('Learning curve for logistic regression (class k=1)')
legend('Train', 'Cross Validation')
xlabel('Number of training examples(scaled)')
ylabel('Error')
axis([0 13 0 150])


%[error_train error_val]=learningCurve(X,y,Xval,yval,lambda);
%for i=1:m
    
%    J=-1/(m)*((y(1:i))'*log(sigmoid((X(1:i,:))*theta)) + (1-(y(1:i)))'*log(1-sigmoid((X(1:i,:))*theta)));%+lambda/(2*m)*(sum(theta.^2)-theta(1,:).^2);
%    grad=1/(m)*((sigmoid((X(1:i,:))*theta)-(y(1:i)))'*(X(1:i,:)))'+lambda/(m)*(theta-[theta(1,:);zeros(size(theta,1)-1,1)]);
%    grad = grad(:);
%    error_train(i)=J;
%end

%for i=1:10
 %  [J,grad]= lrCostFunction(theta,[ones(size(X(1:i,:),1),1) X(1:i,:)],y(1:i),0);
  % error_train(i)=J;
%end