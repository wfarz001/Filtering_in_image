s = load('clown.mat')
rgbImage = ind2rgb(s.X, s.map);
rgbImage=imresize(rgbImage,[64,64]);
I= rgb2gray(rgbImage);
I=double(I);                                  %%% Resizing the original Image to 256X256
% figure;
% subplot(2,2,1),imshow(I);
% title('Original Image')

%%%%Frequency domain Transformation of original image%%%%%
[m,n]=size(I);
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
f_image=wm*im2double(I)*wn   
f1=log(1+fftshift(f_image));
am=real(f1)
phase1=angle(f1);
figure;
subplot(2,1,1);
imshow(am,[]);
title('Amplitude spectrum of original image')
subplot(2,1,2);
imshow(phase1,[]);
title('Phase spectrum of original image')

sigmas = [2 8 16];
figure;

for i=1:length(sigmas)

    % Step 1
    % Filter the image by Gaussian lowpass filter
    N = 25;
    [X, Y] = meshgrid(-N/2:N/2-1, -N/2:N/2-1);
    G = 1/(2*pi*sigmas(i)^2)*exp(-(X.^2 + Y.^2)/(2*sigmas(i)^2));
    G = G/sum(G(:));

    bluredImage = (conv2(I, G, 'same'));
    %subplot(3,4,4*(i-1)+1); 
    %imshow(uint8(bluredImage))
    %title('Blurred Picture')


    % Filter image with Laplacian filter
    H = [-1 1; 1 -1];
    laplacian = conv2(bluredImage, H, 'same');
    logImage = laplacian;
    logImage(abs(laplacian) < .04*max(laplacian(:))) = 128;

    subplot(3,4,4*(i-1)+1); 
    imshow(uint8(logImage))
    title('Filtered Image with LoG (a)')
    
    %%%%Frequency domain Transformation of filtered image%%%%%
    [m,n]=size(logImage);
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
    log_im=wm*im2double(logImage)*wn    
    f1=log(1+fftshift(log_im));
    amplitude=(real(f1))
    phase1=angle(f1);
    subplot(3,4,4*(i-1)+2); 
    imshow(phase1,[]);
    title('Phase of Filtered Image (b)')
    subplot(3,4,4*(i-1)+3); 
    imshow(amplitude,[]);
    title('Amplitude of Filtered Image (c)')
    
    
end