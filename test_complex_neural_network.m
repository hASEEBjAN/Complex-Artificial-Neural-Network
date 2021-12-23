function predict = test_complex_neural_network(net,data)
%this function is used for prediction purposs take net (cell variable
%having trained weights) and input data.
%and give predicted value

input_layer = data; %input layer is input data give to function
Wmn = [net{1}]; %extract input-to-hidden weighted matrix
Wpm = [net{2}]; %extract hidden-to-output weighted matrix

%feed forward 
hmn = Wmn * input_layer.'; %input time input-to-hidden weights is input hidden neuron
hiden_layer = sigmoid ( hmn ); %and sigmoid (activition) of input hidden values in hidden layer value
Op = Wpm * hiden_layer; %hidden nueron time hidden-to-output weights givve input of output
output_layer = sigmoid (Op); %and activition(sigmoid give us an output values

predict = output_layer; % which is prediction of network.