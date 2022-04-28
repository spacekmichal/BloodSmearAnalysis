clear all; close all; clc
obrazky=[1,2,4,7,8,10,11,12,14,17,18,19,20,21,22,23,24,25,28,30,31,32,33,34,35,36,37,38,39,43,44,45,46,48,49,50,51,52,53,54];
%%
for i=1:length(obrazky)
    cislo=string(obrazky(i));
    nazev='image-'+cislo+'.png';
im= im2double(imread(nazev));
% figure 
% imshow (im)
im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);
%% PRO ČERVENÉ KRVINKY
img_C= im_r-im_b;
%% PŘEVOD NA BINAR
% figure
% imshow(img_C)
% binar=imgradient(img_C);
gt=graythresh(img_C);
binar = imbinarize(img_C, 0.11);
% imshowpair(img_C, binar, 'montage')
%% GENERACE STREL PRO DETEKCI
se = strel('disk',2);
closeBW = imclose(binar,se);
% figure, imshow(closeBW)
closeBW=medfilt2(closeBW,[5,5]);
a=imfill(closeBW,'holes');
% b=a;
% figure
% imshow(b)
b=padarray(a,[50,50]);
% imshow(a)
%%
hrany=edge(b,"canny");
% figure
% imshow(im)

[centersBright_C,radiiBright_C,metricBright] = imfindcircles(hrany,[20 45], ...
            'ObjectPolarity','bright','Sensitivity',0.91,'Method','TwoStage','EdgeThreshold',(gt./1.9));
% viscircles(centersBright_C, radiiBright_C,'Color','b');

stredy=[];
polomery=[];
for i=1:length(centersBright_C)
    x=round(centersBright_C(i,1));
    y=round(centersBright_C(i,2));
        if imbinarize(sum(sum(b(y-5:y+5,x-5:x+5))),50)==1
            stredy(i,1)=centersBright_C(i,1);
            stredy(i,2)=centersBright_C(i,2);
            polomery(1,i)=radiiBright_C(i);
        end
end
figure
imshow(im)
viscircles(stredy-50, polomery,'Color','b');
pocet_cervenych= size(centersBright_C,1);
end
%% PRO BÍLE KRVINKY
img_B=im_r;
% img_B= histeq(img_B);
% figure
% imshow(img_B)
%% PŘEVOD NA BINAR
% figure
% imshow(img)

gt=graythresh(img_B);
binar_B = imbinarize(img_B, gt);
% imshowpair(img_B, binar_B, 'montage')
binar_B=~binar_B;
%%
se = strel('disk',5);
closeBW = imclose(binar_B,se);
% figure, imshow(closeBW)
closeBW=medfilt2(closeBW,[5,5]);
b_B=imfill(closeBW,'holes');
% figure
% imshow(b)
%%
hrany_B=edge(b_B,"canny");
% figure
% imshow(im)

[centersBright_B,radiiBright_B,metricBright] = imfindcircles(b_B,[35 60], ...
            'ObjectPolarity','bright','Sensitivity',0.91,'Method','TwoStage','EdgeThreshold',(gt./1.9));
viscircles(centersBright_B, radiiBright_B,'Color','r');

pocet_bilych= size(centersBright_B,1);
