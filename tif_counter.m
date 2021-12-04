function [final_count,results] = tif_counter(filename,index)
count = 0;
dup = 0;
se90 = strel('line',2,90); %structuring elements
se0 = strel('line',2,0);
results = zeros(2,index(end)); %preallocates results variable

for n = index(1):index(end) %for loop for each image

[t,~] = imread(filename,n); %this block performs image analysis (see img_analysis.m for comments)
gray_img = t;
binary_pic = gray_img >= 175;
dilated_pic = imdilate(binary_pic, [se90 se0]);
[cntrs,r] = imfindcircles(dilated_pic,[2 10],'Sensitivity',1,'Method','TwoStage');
count = count + 1;
num_cells = numel(r); %number of cells detected
results(1,count) = n; %puts index positions in row 1 of results variable

if isempty(cntrs) %checks if no cells are detetcted
    continue
end

x_cntrs = cntrs(:,1); %isolates x and y coordinates of centers of cells
y_cntrs = cntrs(:,2);

if count == 1 %empty arrays for first iteration
    previous_x_cntrs = [];
    previous_y_cntrs = [];
end

% checks for duplicate cells and counts them
% compares current coordinates of centers of cells vs those of previous image
for i = 1:length(x_cntrs)
    for j = 1:length(previous_x_cntrs)
        if x_cntrs(i) > previous_x_cntrs(j) - 2 && x_cntrs(i) < previous_x_cntrs(j) + 2
            if y_cntrs(i) > previous_y_cntrs(j) - 2 && y_cntrs(i) < previous_y_cntrs(j) + 2
                dup = dup+1;
            end
        end
    end
end

%calculates newly detected cells and stores in second row of results variable
results(2,count) = num_cells-dup; 
dup = 0;

%sets previous x and y coordinates
previous_x_cntrs = x_cntrs;
previous_y_cntrs = y_cntrs;
end

%reports total individual cell count
final_count = sum(results(2,:));
end