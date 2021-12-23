function d = dsigmoid( layer )
%finding derivation of sigmoid activation function used in back propegation
n = length(layer); 
d = layer.*(ones(n,1)' - layer);
