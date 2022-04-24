clear all; close all; clc
im= im2double(imread('image-45.png'));
figure 
imshow (im)
im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);
i= im_r-im_b;
%% PŘEVOD NA BINAR
img=i;
% figure
% imshow(img)
gt=graythresh(img);
binar = imbinarize(img, 0.11);
% imshowpair(img, binar, 'montage')
%%
se = strel('disk',2);
closeBW = imopen(binar,se);
% figure, imshow(closeBW)
b=imfill(closeBW,'holes');
% figure
% imshow(b)
%%
hrany=edge(b,"canny");
figure
imshow(im)

[centersBright,radiiBright,metricBright] = imfindcircles(hrany,[20 45], ...
            'ObjectPolarity','dark','Sensitivity',0.91,'Method','TwoStage','EdgeThreshold',(gt./1.9));
viscircles(centersBright, radiiBright,'Color','b');



