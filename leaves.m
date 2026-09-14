% Creating  a structural array
myLeaves(1) = struct('CommonName', 'Indian Almond', 'Class', 'Dicotyledonous', 'Venation', 'Net-veined', 'Margin', 'Entire');
figure;
leaf1 = imread("C:\Users\user\Desktop\20260913_094002.jpg");
imshow(leaf1)
%Converting the image to gray scale
figure;
leaf1g = im2gray(leaf1);
imshow(leaf1g)
%Viewing the intensity histogram for leaf1g
figure;
imhist(leaf1g)
% Properties of leaf 2 
myleaves(2)=struct('CommonName', 'Mango', 'Class', 'Dicotyledonous', 'Venation','Net venation','Margin','Entire and wavy');
leaf2 = imread("C:\Users\user\Desktop\20260913_093951.jpg");
figure;
imshow(leaf2)
% A figure showing both the images of leaf1 and leaf2
figure;
imshowpair(leaf1,leaf2,"montage")
%Adjusting the contrast of image of leaf 2 
ds = imlocalbrighten(leaf2);
%Figure showing the contrast of leaf2 and ds
figure;
imshowpair(leaf2,ds,"montage")
%Properties of leaf3
myleaves(3)= struct('CommonName', 'Maize', 'Class', 'Monocotyledonous', 'Venation', 'Parallel', 'Margin', 'Entire');
%Viewing image of leaf 3 
figure;
leaf3 = imread("C:\Users\user\Downloads\image.jpg");
imshow(leaf3)
%Converting leaf3 to grayscale
figure;
leaf3g = im2gray(leaf3);
imshow(leaf3g)
%Computing the sum of imge of leaf3g
S = sum(leaf3g,2);
%Plotting the sum
figure;
plot(S);
title('Vertical Distribution of Leaf Mass');
xlabel('Image Row (Height)');
ylabel('Total Intensity Value');
grid on;
%Properties of leaf 4
myleaves(4) = struct('CommonName', 'Oleander', 'Class', 'Dicotyledonous', 'Venation', 'Net-veined', 'Margin', 'Entire');
%Viewing image of leaf 4 
figure;
leaf4 = imread("C:\Users\user\Desktop\20260913_093759.jpg");
imshow(leaf4)
%  Create the 5x5 averaging filter kernel
Z = fspecial("average", 5);

% Apply the filter to leaf 4
filtered_leaf4 = imfilter(leaf4, Z);

%  Display the original and blurred image side by side
figure;
title('Original Image vs. 5x5 Average Filtered Image')
imshowpair(leaf4, filtered_leaf4, "montage")
%Properties of leaf 5 
myleaves(5) =  struct('CommonName', 'Pohutukawa', 'Class', 'Dicotyledon', 'Venation', 'Net-veined', 'Margin', 'Entire');
%Viewing image of leaf 5
figure;
leaf5 = imread("C:\Users\user\Desktop\20260913_093627.jpg");
imshow(leaf5)
%Converting  image of leaf5 to grayscale
leaf5g = im2gray(leaf5);
%Automazing the threshold selection process
g = imbinarize(leaf5g);
%Creating  a structural element
SE = strel("disk",8);
clean_leaf5 = imclose(g,SE);
%Viewing the image of the clean leaf5
figure;
imshow(clean_leaf5)

% Counting the number of minima
nMin = nnz(leaf5);

% Display the value of the minima
fprintf('The number of minima found is: %d\n', nMin);
disp(t)







