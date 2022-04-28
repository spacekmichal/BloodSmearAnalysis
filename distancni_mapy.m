
clear all; close all; clc
im= im2double(imread('image-23.png'));
figure 
imshow (im)
im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);
%% PRO ČERVENÉ KRVINKY
img_C= im_r-im_b;
binar = imbinarize(img_C, 0.11);
%% erosion of image - smoothing
seD = strel('diamond',2);
binarSmooth = imerode(binar,seD);
binarSmooth = imerode(binarSmooth,seD);
binarSmooth = imerode(binarSmooth,seD);
figure
imshow(binarSmooth)
title('Segmented Image');

%% dm

distMap = bwdist(~binarSmooth, 'euclidean');
figure
imshow(distMap, [])