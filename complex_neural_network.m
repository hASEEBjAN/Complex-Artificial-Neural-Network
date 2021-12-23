function [net] = complex_neural_network (data, n, m, p,eta,itr,plotshow)
%this function is used for creation and training of nueral network
%% initialization
input = data(:,1:n).'; %where I segment data into input
t =data(:,n+1:n+p).'; %output (target t) 

Wmn = rand(m,n) + 1j*rand(m,n); %Weight metrix from input to hidden having size of hiddenxinput
Wpm = rand(p,m) + 1j*rand(p,m); %Weight metrix from hidden to output having size of outputxhidden

%below if condition if for displaying an erro
if plotshow == "true" %if plot show is true
    eitr = 1; mitr=100; e =zeros(itr,1);
    error=zeros(itr./20,1); %than create error vector having size of iteration
    figure(1); %and create figure for displaying erro vs iteration plot
    ax = axes('position',[0.1 0.1 0.8 0.8]); %creating an axes object for plot object
    p = plot(0,0); %than plot object for display plot
    set(p,'parent',ax); %and axes is parent of plot such that we can use every property of axes in plot (set get etc)
    xlabel(ax,'Iteration');
    ylabel(ax,'Mean of MSE');
    title(ax,'MSE graph of training');
end

%% here our training starts
for r=1:itr %loop to number of iterations
    %shuffle the data sample randomly for every iteration
    idx = randperm(size(input,2)); %randomly number generated from 1 to number of samples
    input = input(:,idx); %change samples in input
    t = t(:,idx); %and output according to randomly generated numbers
    Y = zeros(size(input,2),p).';
    for s =1:size(input,2) %than iterated over each sample in a single iteration
        %% feed forward
        X = input(:,s); %select an input from sample
        h = Wmn* X; %input times weight(input to hidden) is input of hidden neuron
        H = sigmoid (h); %activation of input of hidden layer gave value of hidden neuron
        y = Wpm * H; %hidden layer times weight(hidden to output) is input of output neuron
        Y(:,s) = sigmoid(y); %and output will be activation of input of output neuron
        
        %feedforward finished
        %% back propegation or gradient decent
       
        %first use equation for finding derivation of error vs
        %hidden-to-output-weights
        
        dyr = (real(t(:,s)) - real(Y(:,s))) .* real(Y(:,s)) .* (1-real(Y(:,s)));
        dyi = (imag(t(:,s)) - imag(Y(:,s))) .* imag(Y(:,s)) .* (1-imag(Y(:,s)));
        
        de_by_dWpmr = -(dyr*real(H)' + dyi * imag(H)');
        de_by_dWpmi = -(-dyr * imag(H)' + dyi * real(H)');
        
        %than propegate error to input-to-hidden-weights
        dhrr = (real(Wpm).' * dyr) .* real(H) .* (1-real(H));
        dhri = -(imag(Wpm).' * dyr) .* imag(H) .* (1-imag(H));
        dhir = (imag(Wpm).' * dyi) .* real(H) .* (1-real(H));
        dhii = (real(Wpm).' * dyi) .* imag(H) .* (1-imag(H));
        
        de_by_dWmnr = dhrr * real(X).' + dhii * imag(X).' + dhir * real(X).' + dhri * imag(X).';
        de_by_dWmni = dhrr * imag(X).' - dhii * real(X).' + dhir * imag(X).' - dhri * real(X).';
        
        %change in weights or slop of weights
        de_by_dWpm = de_by_dWpmr + 1j * de_by_dWpmi;
        de_by_dWmn = de_by_dWmnr + 1j * de_by_dWmni;
        
        %add the negative change with previous weights such that our aim to
        %go down the slop
        Wpm = Wpm - eta * de_by_dWpm;
        Wmn = Wmn - eta * de_by_dWmn;
        %backpropegation finished
    end
    if plotshow == "true"
        e(itr) = mean(((real(t)-real(Y).^2 + (imag(t)-imag(Y)).^2)./2),'all');
        if rem(itr,mitr) == 0
            error(eitr) = e(itr);
            eitr = eitr+1;
        end
    end
end
%if plot show is true than update the plot values 
if plotshow == "true"
    set(p,'XData',1:eitr-1); 
    set(p,'YData',error);
end
net = {Wmn Wpm}; %return weights (network) as cell named net