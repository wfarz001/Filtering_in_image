%Design the Gaussian Kernel
%Standard Deviation
sigma = 1.76;
%Window size
sz = 2;
[x,y]=meshgrid(-sz:sz,-sz:sz);  %% Formula: 1/2*pi*(sigma)^2 * exp((x^2+y^2)/2*(sigma)^2)

M = size(x,1)-1;
N = size(y,1)-1;
Exp_comp = -(x.^2+y.^2)/(2*sigma*sigma);
Kernel= exp(Exp_comp)/(2*pi*sigma*sigma); % Gaussian Kernel 

%%%%Frequency Domain Transformation of the Gaussian Kernel%%%%%
[m,n]=size(Kernel);
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
f=wm*im2double(Kernel)*wn    % coefficients of 3*3 kernel in frequency domain 

f1=log(1+fftshift(f));
amplitude=(real(f1))
figure;
imshow(amplitude,[]);
title('Amplitude Spectrum of  Gaussian filter')
