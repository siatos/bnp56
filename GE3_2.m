%% read original CT-scan and mask images
CT_img = imread('image268x324.png')
figure(1)
imshow(CT_img)
title('Initial image - CT scan')

mask_img = imread('mask.png')
figure(2)
imshow(mask_img)
title('Mask Image for Region Isolation')

%% Isolate Region of the original Image-CT scan using a Mask

%% Matlab uses value 255 for while while Octave 1
%% ANDing buy element multiplication of two matrices will work for Ocate 
%% but not for Matlab
mask_img = mask_img/255  

%% this one should also work
%%mask_img =uint8(imbinarize(mask_img))

ANDimg = AND_images(CT_img, mask_img)
figure(3)
imshow(ANDimg)
title('Isolate Region using AND with Mask')

%% Normalize Isolated Region
NORMimg = imadjust(ANDimg)
figure(4)
imshow(NORMimg)
title('Adjusted Isolated Region')

%% Apply Inverse Normalized Isolation Mask on the original Image - CT scan
ANDINVimg = ANDINV_images(CT_img, NORMimg)
figure(5)
imshow(ANDINVimg)
title('AND Inverse images')

%% Max 
img_rows = size(CT_img, 1)
img_cols = size(CT_img, 2)
maxout_img = maxedout (CT_img, NORMimg, img_rows, img_cols)
figure(6)
imshow(maxout_img)
title('MAX out image')


%% Function AND images %%
function out = AND_images(img, mask)
  img = double(img);
  mask = double(mask);
  out = uint8(img.*mask);
end

%% Function AND images with inverse mask %%
function out = ANDINV_images(img, mask)
  img = double(img);
  mask = double(mask);
  inv_mask = 1 - mask
  out = uint8(img.* inv_mask);
end

%% Function max per cell on images %%
function out = maxedout (image1, image2, rows, cols)
  for i = 1:rows
      for j = 1:cols
          if image1(i,j) < image2(i,j)
              out(i,j) = image2(i,j);
          else
              out(i,j) = image1(i,j);
          end
      end
  end
end
