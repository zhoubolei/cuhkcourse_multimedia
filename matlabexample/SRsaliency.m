function [salMap] = SRsaliency(img_in)
%% Image Saliency: spectral residual approach
% References
%   Hou, X., Zhang, L.: Saliency detection: A spectral residual approach. 
%                       In: Proceedings CVPR ?07, vol. 1, pp. 1-8 (2007)
% Preparing the image 

if size(img_in, 3) == 3
    salMap_ave = zeros(size(img_in,1),size(img_in,2));
    for i = 1:3
        salMap = compute_single(squeeze(img_in(:,:,i)));
        salMap_ave = salMap_ave + salMap;
    end
    salMap = salMap_ave/3;
else
    salMap = compute_single(img_in);

end
end

function salMap_single = compute_single(img_grey)
    img_start = im2double(img_grey);
    [rows cols] = size(img_start);
    inImg = imresize(img_start, [64, 64], 'bilinear');

    % The actual Spectral Residual computation: just 5 Matlab lines!
    myFFT = fft2(inImg); 
    myLogAmplitude = log(abs(myFFT));
    myPhase = angle(myFFT);
    mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate'); 
    saliencyMap = abs(ifft2(exp(mySpectralResidual + 1i*myPhase))).^2;

    % After-Effect
    saliencyMap = imfilter(saliencyMap, fspecial('disk', 3));

    % Resizing from 64*64 to the original size
    saliencyMap = mat2gray(saliencyMap);
    saliencyMap = imresize(saliencyMap, [rows cols], 'bilinear');

    salMap_single = im2double(saliencyMap);
end

