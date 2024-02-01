%% read original CT-scan and mask images
CT_img = imread('image268x324.png')
mask_img = imread('mask.png')

%% Isolate Region of the original Image-CT scan using a Mask
ANDimg = CT_img.* mask_img

%% Normalize Isolated Region
NORMimg = imadjust(ANDimg)

%% Apply Inverse Normalized Isolation Mask on the original Image - CT scan
ANDINVimg = CT_img.* (1-mask_img);

%% Max 
img_rows = size(CT_img, 1)
img_cols = size(CT_img, 2)
%maxout_img = maxedout (CT_img, NORMimg, img_rows, img_cols)
%maxout_img = maxedout (NORMimg, CT_img, img_rows, img_cols)

subplot(1, 6, 1)
imshow(CT_img)
title('Initial image CT scan')
subplot(1, 6, 2)
imshow(mask_img)
title('Mask Image for Region Isolation')
subplot(1, 6, 3)
imshow(ANDimg)
title('Isolate Region using AND with Mask')
subplot(1, 6, 4)
imshow(NORMimg)
title('Normalized Isolated Region')
subplot(1, 6, 5)
imshow(ANDINVimg)
title('AND Inverse Mask ')
subplot(1, 6, 6)
imshow(maxout_img)
title('MAX out image')



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
