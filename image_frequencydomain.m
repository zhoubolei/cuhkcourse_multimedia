img = imread('test.jpg');
imshow(img);
size(img);

img_in = imresize(img, 0.3);
img_grey = rgb2gray(img_in);

%% DCT transform
% compute DCT coefficient
J = dct2(img_grey);

% visualize the coefficient
figure
imshow(log(abs(J)),[])
colormap(gca,jet(64))
colorbar

% compress
idx = abs(J)< 100;
J(idx) = 0;
display(sum(idx(:))/length(J(:)))
K = idct2(J);
imshowpair(img_grey, K,'montage')

%% Fourier transform
Y = fft2(img_grey);
Y_shift = fftshift(Y);
% visualize the log spectrum curve
figure, surf(log(abs(Y_shift)));

