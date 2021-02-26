img = imread('data/test.jpg');
imshow(img);
size(img);

img_in = imresize(img, 0.3);
img_gray = rgb2gray(img_in);

%% DCT transform
% compute DCT coefficient
J = dct2(img_gray);

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
imshowpair(img_gray, K,'montage')

%% Fourier transform
Y = fft2(img_gray);
Y_shift = fftshift(Y);
% visualize the log spectrum curve
figure, surf(log(abs(Y_shift)));

