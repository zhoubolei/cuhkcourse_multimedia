%% start

img = im2double(imread('data/test.jpg'));

img_in = imresize(img, 0.5);
img_gray = rgb2gray(img_in);

% add noise
% img_grey = imnoise(img_grey,'salt & pepper',0.05);
%% highpass filtering
k1 = [0 -1 0;-1 5 -1;0 -1 0];
k2 = [1 -2 1;-2 5 -2;1 -2 1];
k3 = 1/7 * [-1 -2 -1;-2 19 -2;-1 -2 -1];

response_highpass = conv2(k3, img_gray);
figure,montage({img_gray,response_highpass});

%% lowpass filtering
k1 = ones(3,3)./9;
k2 = [1 1 1;1 2 1;1 1 1]./10;
k3 = [1 2 1;2 4 2;1 2 1]./16;
response_lowpass = conv2(k1, img_gray);
figure,montage({img_gray,response_lowpass});

%% median filtering
response_median = medfilt2(img_gray, [5,5]);
figure,montage({img_gray, response_median});
