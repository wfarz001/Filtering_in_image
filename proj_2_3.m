s = load('clown.mat')
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[128,128]);
I= rgb2gray(rgbImage);

PSF = fspecial('motion',21,11);
Idouble = im2double(I);
blurred = imfilter(Idouble,PSF,'conv','circular');
figure;
subplot(2,1,1);imshow(blurred)
title('Blurred Image with Motion')

wnr1 = deconvwnr(blurred,PSF);
subplot(2,1,2); imshow(wnr1)
title('Restored Blurred Image')

noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred,'gaussian',noise_mean,noise_var);
figure;
subplot(3,1,1);imshow(blurred_noisy)
title('Blurred and Noisy Image with Gaussian')

wnr2 = deconvwnr(blurred_noisy,PSF);
subplot(3,1,2);imshow(wnr2)
title('Restoration of Blurred Noisy Image (NSR = 0)')

signal_var = var(Idouble(:));
NSR = noise_var / signal_var;
wnr3 = deconvwnr(blurred_noisy,PSF,NSR);
subplot(3,1,3);imshow(wnr3)
title('Restoration of Blurred Noisy Image (Estimated NSR)')