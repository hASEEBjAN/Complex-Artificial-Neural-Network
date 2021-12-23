function sig = sigmoid ( layer )
%for finding sigmoid of vector (activation)
lr = real(layer); %real part of layer
li = imag(layer); %imaginery part of layer
sig = 1./(1+ exp(-lr)) + 1j * (1./(1+ exp(-li))); %sigmoid of layer is sigmoid of real plus sigmoid of imaginery