k=0.00025; %k=0.0025 (high), k=0.001 (mid), k=0.00025 (low)
sz=2;
[x,y]=meshgrid(-sz:sz,-sz:sz);
M = size(x,1)-1;
N = size(y,1)-1;
Exp_comp = -k*(x.^2+y.^2)*(5/6); % Creating low turbulence with the formula (5.8)
Kernel= exp(Exp_comp)

s = load('clown.mat')
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[128,128]);
I= rgb2gray(rgbImage);

Idouble = im2double(I);
blurred = imfilter(Idouble,Kernel,'conv','circular');
figure;
subplot(2,1,1);imshow(blurred)
title('Blurred Image')

wnr1 = deconvwnr(blurred,Kernel);
subplot(2,1,2); imshow(wnr1)
title('Restored Blurred Image')