s = load('clown.mat')
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[128,128]);
I= rgb2gray(rgbImage);                                        %%% Resizing the original Image to 256X256
figure;
subplot(2,2,1),imshow(I);
title('Original Image')

% varI= std2(I)^2;
% SNR= 3;
% sigma_noise = sqrt(varI/10^(SNR/10));
IN2 = imnoise(I,'gaussian',0,0.025); % using imnoise
subplot(2,2,2),imshow(IN2);
title('Nosiy Image (Gaussian)')

%windowSize = 3; 
%kernel = ones(windowSize, windowSize) / windowSize ^ 2;  % Averaging filter kernel 

I3=filter2(fspecial('average',3),IN2); % applying average filter on noisy image
subplot(2,2,3),imshow(I3);
title('Average filtering on noisy image')

%%% DFT of noise filtered image%%%%
In=fft2(I3);
In=log(1+fftshift(In))
%In_real= real(In)
% figure;
% subplot(2,2,1),imshow(abs(In),[]);
% title('Amplitude spectrum of noise filtered image')


% % %%% DFT fourier transform of original image and getting phase%%%%

I_or=fft2(I);
I_or=log(1+fftshift(I_or))
I_phase=I./abs(I_or);
% subplot(2,2,3),imshow(angle(I_or),[]);
% title('Phase spectrum of original image')
% 


I_k=abs(In).*I_phase;
subplot(2,2,4);imshow(abs(I_k))
title('Final Image')