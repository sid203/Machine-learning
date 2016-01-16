function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

m = size(X, 1);
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% Part 3: Implement regularization with the cost function and gradients.

eye_matrix=eye(num_labels);
y_matrix=eye_matrix(y,:);

a1=[ones(size(X,1),1) X];
z2=a1*Theta1';
a2=[ones(size(X,1),1) sigmoid(z2)];
z3=sigmoid(a2*Theta2');

J=(-1/m)*sum(sum((y_matrix.*log(z3))+((1-y_matrix).*log(1-z3)))) + (lambda/(2*m))*((sum(sum(Theta1(:,[2:size(Theta1,2)]).^2)))+(sum(sum(Theta2(:,[2:size(Theta2,2)]).^2))));


d3=z3-y_matrix;
d2=d3*Theta2(:,2:end).*sigmoidGradient(z2);
delta1=d2'*a1;
delta2=d3'*a2;
Theta1(:,1)=0;
Theta2(:,1)=0;
Theta1=(lambda/(m))*Theta1;
Theta2=(lambda/(m))*Theta2;
Theta1_grad=delta1/m +  Theta1;
Theta2_grad=delta2/m + Theta2;

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
