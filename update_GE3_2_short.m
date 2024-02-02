%% read original CT-scan and mask images
CT = imread('image268x324.png')
mask = imread('mask.png', 'png')

%% Matlab uses value 255 for while while Octave 1
%% ANDing buy element multiplication of two matrices will work for Ocate 
%% but not for Matlab
mask2 = mask/255   


%% Isolate Region of the original Image-CT scan using a Mask
ANDed = mask2.* CT

%% Normalize Isolated Region
NORMalized = imadjust(ANDed)


%% Apply Inverse Normalized Isolation Mask on the original Image - CT scan
ANDINV = CT.* (1-mask2);

%% Max 
img_rows = size(CT, 1)
img_cols = size(CT, 2)
%maxout_img = maxedout (CT_img, NORMimg, img_rows, img_cols)
maxout = maxedout(NORMalized, CT, img_rows, img_cols)

subplot(1, 6, 1), imshow(CT), title('CT scan')
subplot(1, 6, 2), imshow(mask), title('Mask')
subplot(1, 6, 3), imshow(ANDed), title('Isolate Region using AND with Mask')
subplot(1, 6, 4), imshow(NORMalized), title('Normalized Isolated Region')
subplot(1, 6, 5), imshow(ANDINV), title('AND Inverse Mask ')
subplot(1, 6, 6), imshow(maxout), title('MAX out image')



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
