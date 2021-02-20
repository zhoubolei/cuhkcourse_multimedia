
%% Bonus 2: copmute video saliency using Phase Discrephancy method
% B. Zhou, X. Hou and L. Zhang. "A phase discrepancy analysis of object motion. " 
% Proceedings of 10th Asian Conference on Computer Vision (ACCV), 2010.

% mkdir frames
% ffmpeg -i test.mp4 -q:v 1 frame/image-%4d.jpg

clear
dataPath='frames/';  % the path of video frames
mFrame=5;                    % the number of consecutive saliency maps combined 

%% initial processing
reScale=[120 160];
imgDir = dir(dataPath);
imgDir = imgDir(4:end);
nFrame=length(imgDir);


batch=zeros(reScale(1),reScale(2),mFrame);
for i=1:mFrame         
    batch(:,:,i)=imresize(rgb2gray(imread([dataPath imgDir(i).name])),[reScale(1),reScale(2)]);
end

%% 
figure
for i = mFrame:1: nFrame

    curFrame = imread([dataPath imgDir(i).name]);
    batch(:,:,1:end-1) = batch(:,:,2:end);
    batch(:,:,end) = imresize(rgb2gray(curFrame),[reScale(1),reScale(2)]);
    
    motionMap = compPhaseBatch(batch);  % compute the motion saliency maps
    subplot(1,2,1), imshow(curFrame), subplot(1,2,2),imshow(motionMap),drawnow

end




