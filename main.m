%% XOR Section
data = load('xor.mat'); %I loaded xor data whch I stored previously from paper
input_size = data.input_size; %input size from loaded data
output_size = data.output_size; %output size from loaded data
data = data.data; %data from loaded data

hiddenlayer_size = 20; %defining number of node in hidden layer
itr = 10000; %number of iteration for training
eta = 0.35; %learning rate
plot = "true"; %display erro plot
%here I give data, input size, hidden layer size, output size, number of
%iteration, learning rate, to function named complex nueral network and
%received net (cell array) which contain train weights of input to hidden
%and hidden to output layer.
net = complex_neural_network(data,input_size,hiddenlayer_size,output_size,eta,itr,plot);

%for evaluation I pass all input (size = 16) to test function (created by me) 
%using loops to give each input one-by-one and receiving prediction from
%test function.
pred = zeros(size(data,1),1); %size of prediction would be size of input sample in dataset
for i =1:size(data,1) %loop to every sample in dataset
    pred(i) = test_complex_neural_network(net,data(i,1:input_size)); %and predict output of input using our train neural network
end

%ploting original output vs predicted output
clear plot
figure(2);
plot(imag(data(:,3)),real(data(:,3)),'or'); %ploting of original outputs as red circle
hold on;
plot(imag(pred),real(pred),'*k'); %ploting predicted output as black staric
set(gca,'xlim',[-0.1 1.1]);  
set(gca,'ylim',[-0.1 1.1]);
hold off;
title('Actual vs Predicted Outputs');
xlabel('Real Values');
ylabel('Imaginery Values');
legend('Actual','Predicted');

%% Power Supply Load Flow

data = load('PS_load.mat'); %loading stored dataset created by me in savedata.m
input_size = data.input_size; %input size (which is 2)
output_size = data.output_size; %output size( which is 2)
data = data.data; %data form dataset

hiddenlayer_size = 10; %hidden layer size
itr = 100000; %number of iteration
eta = 0.35; %learning rate
plot = "false"; %display error plot
%again train the network as stated in above section
net = complex_neural_network(data,input_size,hiddenlayer_size,output_size,eta,itr,plot);

%again do prediction as stated in above section
pred = zeros(size(data,1),2);
for i =1:size(data,1)
    pred(i,:) = test_complex_neural_network(net,data(i,1:input_size));
end

%as in paper the result of power supply load flow dataset resutls is
%displayed in tatble so below I created table for showing results.
target = pred; %predicted values as Target from neural network
actual = data(:,input_size+1:input_size+output_size); %actual output from dataset
%and also below I calculated error using mean square erro method
error = ((real(actual) - real(target)).^2 + (imag(actual) - imag(target)).^2)./2;

%for displaying table
fig = figure(3); %first create a figure
%than heading of figure as Text field (uneditable)
uicontrol('style','text',... %ui element as textfield (uneditable
    'string','Table display Actual Values and Predicted Vlues by Neural Network',... %heading or text to be displayed on figure
    'fontsize',18,... %font size of text diplayed
    'Units','normalize',... %position of text field is normalized or adoptable ot size of figure (maximize etc).
    'Position',[0.05 0.75 0.9 0.1]); %Position of heading in [x y width height] format in figure.
%below heading we have a table using uitable controller
uitable('Data',[actual target error],... %data in table is in the format of actual data , target data and erro for both S1 and S2 outputs
    'ColumnName',{'Target Value (S1)','Target Value (S2)', 'Actual Value (S1)','Actual Value (S2)','Error (S1)','Erro (S2)'},... %heading of column
    'Units','normalized',... %adoptively change size with size of figure
    'fontsize',14,... %font size of data in table
    'ColumnFormat',{[],[],[],[],'bank','bank'},... %formating erro from complex in number using bank formating because we have no other choice in matlab and in this format the erro is displayed as real of 3 decimal placess
    'ColumnWidth',{160},... %colum width is 160 pixel (I check other size and this size fit out data precisely).
    'Position',[0.05 0.15 0.73 0.545]); %position of table are in format [x y width height]  and below heading.
