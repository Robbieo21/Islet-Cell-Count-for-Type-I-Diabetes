function [count_img] = img_analysis(filename,index)
[t,cmap] = imread(filename,index); %read image
raw_img = ind2rgb(t,cmap); %create a colored image
gray_img = t; %grayscale image
binary_pic = gray_img >= 175; %create binary image
se90 = strel('line',2,90); %structuring elements
se0 = strel('line',2,0);
dilated_pic = imdilate(binary_pic, [se90 se0]); %dilate image
[cntrs,r] = imfindcircles(dilated_pic,[2 10],'Sensitivity',0.9,'Method','TwoStage'); %find centers and radii of cells
cell_count = numel(r); %number of cells
txt = ['Cell Count: ' num2str(cell_count,'%d')]; %cell count label on image
count_img = insertText(raw_img,[415 1],txt,'BoxOpacity',0,'TextColor','white'); %insert label
imshow(count_img,cmap) %show image
viscircles(cntrs,r,'LineWidth',1,"Color",'w'); %draw circles around detected cells
title('Cell Detection of Raw Image')
end