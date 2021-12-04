%BME3053C Final Project
%Authors: Robert Ovalle, Alex Armstrong, Conor Given

clc;
clear;
close all hidden;
warning('off','all');

filename = input('Enter name of TIF file: ','s');
index = input('Enter an index or a range of indices: ');

if length(index) == 1 %if one number is entered then run image analysis
    count_img = img_analysis(filename,index);
elseif length(index) >= 1 %if an array is detected then run the cell counter
    [final_count,results] = tif_counter(filename,index);
    fprintf('Individual Cells Counted: ')
    fprintf('%d\n',final_count)
    fprintf('Individual Image Results: \n')
    fprintf('Index:     ')
    fprintf('%4g ',results(1,:)); fprintf('\n')
    fprintf('New Cells: ')
    fprintf('%4g ',results(2,:)); fprintf('\n')
end
    
