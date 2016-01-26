function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables

m = length(y); % number of training examples
J = 0;
grad = zeros(size(theta));

J= (1/(2*m))*(X*theta-y)'*(X*theta-y) + (lambda/(2*m))* sum(theta(2:end,:).^2);
a=theta;
a(1,:)=0;
grad=(1/m)*((X*theta-y)'*X)' + (lambda/m)*(a);
grad = grad(:);

end
