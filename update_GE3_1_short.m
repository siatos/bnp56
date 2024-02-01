%% read mri and pet images
mri_img = imread('mri221x279.png')
pet_img = imread('petGrey221x279.png')
fused_img = (mri_img + pet_img)/2
normalized_img = normalize_image(fused_img)


subplot(1, 4, 1), imshow(mri_img), title('MRI image')
subplot(1, 4, 2), imshow(pet_img), title('PET image')
subplot(1, 4, 3), imshow(fused_img), title('FUSED image')
subplot(1, 4, 4), imshow(normalized_img), title('Normalized image')

%% Function normalize image %%
function out = normalize_image(input_img)
  input = double(input_img);
  minval = min(min(input));
  maxval = max(max(input));
  out = uint8((input - minval) * 255 / (maxval - minval));
end
