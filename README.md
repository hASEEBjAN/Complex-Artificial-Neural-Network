# Complex-Artificial-Neural-Network
It was an extended ANN an implementation of ANN for complex values (A+jB). This work was done at the start of my learning.

## Outputs
When running the main.m file couple of times. Therefore, the good results, which I obtain, are near to average of mean square error is 0.15 (shown in figure 1). But it is not necessary that the graph and MSE is same for every training. While evaluating outputs and results using test_complex_neural_network.m (created for prediction). I got good results in term of plots of predicted values and actual values (shown in figure 2) and error.

![image](https://user-images.githubusercontent.com/37823818/147209572-03d9f981-62af-4249-b2b1-ba0000b079f3.png)
![image](https://user-images.githubusercontent.com/37823818/147209582-cfd59f91-ce4d-431d-a7c5-fcc31580dd21.png)

For the second example I created a dataset (using an equation 1) from data mention in paper. And while training for some times I got the result (as shown in figure 3). Looking to the last two columns of error. It is clear that we got good results here aswell.

![image](https://user-images.githubusercontent.com/37823818/147209638-7d382564-4364-4a61-830a-9558d934f587.png)

## Explanation:
### How to run the code to obtain the results?
I created the main.m file to obtain the results in GUI format. It first load the data of XOR from xor.mat and train on it plot some graph shown in paper. And then in second I load data from PS_load.mat and repeat the process but here the data is shown as table so I use uitable and figure to show that data.
### How this project works?
Here we have five import files. First, of them is main.m file, which load data from .mat files and show the results according to paper. Second, we have comple_neural_network.m file where I created the training take place and due to comments it is self-explanatory for equations in back propagation section look at to paper. Third file is test_complex_neural_network.m, which is for prediction on trained network. Last two files are sigmoid.m and dsigmoid.m used for sigmoid (activation) and derivative of sigmoid (backpropagation). Besides these, we have one other file, which is savedata.m, which is used for data preparation and storing in .mat format (xor.mat and PS_load.mat). In addition, have no contribution other than that.


