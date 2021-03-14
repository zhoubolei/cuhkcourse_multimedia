%% image preprocessing
I = imread('Original.tiff'); % read image
I_gray = rgb2gray(I);        % color to gray
I_in = im2double(I_gray);    % uint8 to double

imwrite(I_in,'I_in.jpg');                   % save input image
I_in_size = imfinfo('I_in.jpg').FileSize;   % size of input image

%% traditional DCT
% refer to dct2 for help
J = dct2(I_gray);

figure;
imshow(log(abs(J)),[]);
colormap(jet);
colorbar;
% print;                % uncomment this sentence if needed

J(abs(J) < 10) = 0;
I_trad_out = idct2(J);

%% traditional output
imwrite(uint8(I_trad_out),'I_trad_out.jpg');          % save output image
I_trad_out_size = imfinfo('I_trad_out.jpg').FileSize; % size of output image

trad_compress_ratio = I_trad_out_size/I_in_size;
fprintf('Compress ratio is %1.4f .\n',trad_compress_ratio);

%% Zonal DCT
T = dctmtx(8);                      % 8*8 DCT matrix
fun_dct = @(block_struct) T*block_struct.data*T';
                                    % function T*x*T'
B = blockproc(I_in,[8 8],fun_dct);  % DCT

figure;
imshow(log(abs(B)),[]);
colormap(jet);
colorbar;
% print;                % uncomment this sentence if needed

%% Zonal coding
mask = [1   1   1   1   0   0   0   0
        1   1   1   0   0   0   0   0
        1   1   0   0   0   0   0   0
        1   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0];             % Zonal coding mask
fun_mask = @(block_struct) mask.*block_struct.data; % function mask.*x
B_mask = blockproc(B,[8 8],fun_mask);               % apply mask

%% inverse DCT
fun_idct = @(block_struct) T'*block_struct.data*T; % function T'*x*T
I_out =blockproc(B_mask,[8,8],fun_idct);           % inverse DCT

%% Zonal DCT output
imwrite(I_out,'I_out.jpg');                 % save output image
I_out_size = imfinfo('I_out.jpg').FileSize; % size of output image

compress_ratio = I_out_size/I_in_size;
fprintf('Compress ratio is %1.4f .\n',compress_ratio);

%% compare images
figure;
subplot(3,1,1);
imshowpair(I,I_gray,'montage')
title('Original Color Image (Left) and Grayscale Image (Right)');
subplot(3,1,2);
imshowpair(I_in,I_trad_out,'montage')
title('Original Grayscale Image (Left) and Traditional DCT Image (Right)');
subplot(3,1,3);
imshowpair(I_in,I_out,'montage')
title('Original Grayscale Image (Left) and Zonal DCT Image (Right)');
% print;                % uncomment this sentence if needed
