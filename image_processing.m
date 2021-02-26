%% start

img = imread('data/test.jpg');
imshow(img);
size(img);

img_in = imresize(img, 0.6);
img_gray = rgb2gray(img_in);


%% color space conversion
ycbcrmap = rgb2ycbcr(img_in);
figure, imshow(ycbcrmap);
imshow(squeeze(ycbcrmap(:,:,2)));

%% image enhancement
img_test = img_gray*0.5;
figure, imhist(img_test);
img_histeq = histeq(img_gray); % match uniform distribution
figure, imhist(img_histeq);
figure, montage({img_test, img_histeq})

%% filtering
h = fspecial('gaussian', [20, 20]);
img_out = imfilter(img_in, h);
figure, imshow([img_in img_out]);

% edge detection
img_edge = edge(rgb2gray(img_in), 'Canny');
imshow(img_edge);

%% denoising
img_noise = imnoise(img_gray,'salt & pepper',0.05);
imshow(img_noise)

% median filtering
img_out = medfilt2(img_noise, [5,5]);
imshow([img_noise img_out]);


