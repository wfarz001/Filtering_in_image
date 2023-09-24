windowSize = 3; 
kernel = ones(windowSize, windowSize) / windowSize ^ 2;  % Averaging filter kernel 
s = load('clown.mat')
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[128,128]);
I= rgb2gray(rgbImage);                                        %%% Resizing the original Image to 256X256
figure;
subplot(2,2,1),imshow(I);
title('Original Image')

blurredImage = imfilter(I, kernel, 'symmetric');
subplot(2,2,2);
imshow(blurredImage);
title('Blurred Image (Averaging filter)')

[m,n]=size(kernel);
wm= zeros(m,n);
wn= zeros(m,n);
for u=0:(m-1)
    for x=0:(m-1)
        wm(u+1,x+1)=exp(-2*pi*1i/m*x*u); % fourier transform in x axis
    end
end

for v=0:(n-1)
    for y=0:(n-1)
        wn(y+1,v+1)=exp(-2*pi*1i/n*y*v); %fourier transform in y axis 
    end
end
f=wm*im2double(kernel)*wn    % coefficients of 3*3 kernel in frequency domain 

f1=log(1+fftshift(f));
amplitude=(real(f1))
figure;
imshow(amplitude,[]);
title('Amplitude Spectrum of  Averaging filter')