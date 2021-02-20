%% Concrete example 1: compute the image saliency using spectral residual approach
% References
%   Hou, X., Zhang, L.: Saliency detection: A spectral residual approach. 
% Proceedings of Computer Vision and Pattern Recognition (CVPR), 2007.
% check cvpr2007.pdf

img = imread('test.jpg');
img_in = imresize(img, 0.5);

img_sal_in = im2double(img_in);
[salMap] = SRsaliency(img_in);
figure, montage({img_sal_in, salMap});

