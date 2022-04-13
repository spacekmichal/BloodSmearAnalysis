clear all; close all; clc
im= im2double(imread('image-2.png'));
figure 
imshow (im)
im_r=im(:,:,1);
im_g=im(:,:,2);
im_b=im(:,:,3);

i= im_r-im_b;
%% PŘEVOD NA BINAR
img=i;
figure
imshow(img)

gt = graythresh(img);
binar = imbinarize(img, gt);
imshowpair(img, binar, 'montage')
%% DIST MAPA

bw=binar;

rozodi=watershed(bw);
negativ=1-bw;
mapa=bwdist(negativ);
mapa=-mapa;
mapa(mapa==0)=-Inf;
bw2=watershed(mapa);

figure
subplot(141)
imshow(bw,[])
title('Puvodní obrazek')
subplot(142)
mesh(bwdist(1-bw))
title('Distanční mapai')
subplot(143)
mesh(mapa)
title('upravená distanční mapa')
subplot(144)
imshow(label2rgb(bw2),[])
title('Segmentace obrazu')

%% Chan-Vese
img4 = activecontour(binar, bw ,200, 'Chan-Vese'); hold on
visboundaries(img4); 

figure
imshow(labeloverlay(im, img4));

%% multithresh
prahy= multithresh(i,3);
t= imquantize(i,prahy);
rgb=label2rgb(t);
figure
imshow(t,[])
figure
imshow(rgb)
red=rgb(:,:,2);
figure
imshow(red)