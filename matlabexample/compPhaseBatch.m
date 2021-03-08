function motionmap = compPhaseBatch(batch)
% B. Zhou, X. Hou and L. Zhang. "A phase discrepancy analysis of object motion. " 
% Proceedings of 10th Asian Conference on Computer Vision (ACCV), 2010.

nImg=size(batch,3); 
motionmap=zeros(size(batch,1),size(batch,2));

for i=1:nImg-1
    
    curFrame1=batch(:,:,i);curFrame2=batch(:,:,i+1);
    myFFT1=fft2(curFrame1);
    Amp1=abs(myFFT1);
    Phase1=angle(myFFT1);
    myFFT2=fft2(curFrame2);
    Amp2=abs(myFFT2);
    Phase2=angle(myFFT2);
    mMap1=abs(ifft2((Amp1-Amp2).*exp(1i*Phase1)));
    mMap2=abs(ifft2((Amp1-Amp2).*exp(1i*Phase2)));
    mMap=mMap1.*mMap2;                 %% current saliency map
    
    motionmap=motionmap+mMap;          %% linearly adding up multiple saliency maps
end

 motionmap=(imfilter(motionmap, fspecial('gaussian', [15 15],3))); 
 motionmap=mat2gray(motionmap);
   
end

