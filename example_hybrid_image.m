% create hybrid image
% Aude Oliva, Antonio Torralba and Philippe G. Schyns (2006). "Hybrid images"
% ACM Transactions on Graphics. 
clc
close all;

% first_image_path='data/obama.jpg';
% second_image_path='data/michelle_obama.jpg';

first_image_path='data/einstein.jpg';
second_image_path='data/marilyn.jpg';

first_image=im2double(imread(first_image_path));
second_image=im2double(imread(second_image_path));

% create a lowpass filter (try different cutoff-freqency
cutoff_frequency = 3;
filter = fspecial('Gaussian', [cutoff_frequency*4+1], cutoff_frequency);

low_frequencies = imfilter(first_image, filter);
high_frequencies = second_image - imfilter(second_image, filter);

hybrid = low_frequencies + high_frequencies;
figure; subplot(1,3,1), imshow(low_frequencies)
subplot(1,3,2), imshow(high_frequencies+0.5);
subplot(1,3,3); imshow(hybrid);
vis = vis_hybrid_image(hybrid);
figure,imshow(vis);

