function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization

m = length(y); % number of training examples 
J = 0;
grad = zeros(size(theta));

J=-1/(m)*(y'*log(sigmoid(X*theta)) + (1-y)'*log(1-sigmoid(X*theta)))+lambda/(2*m)*(sum(theta.^2)-theta(1,:).^2);
grad=1/(m)*((sigmoid(X*theta)-y)'*X)'+lambda/(m)*(theta-[theta(1,:);zeros(size(theta,1)-1,1)]);
grad = grad(:);

end
