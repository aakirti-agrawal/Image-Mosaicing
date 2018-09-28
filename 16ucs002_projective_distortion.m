clear all;
img = imread('image.jpg');

%choosing 4 points from given image
[x y t] = impixel(img);

%input image coordinates
%we need 4 corresponding pair of coordinates
x1 = x(1);
y1 = y(1);
x2 = x(2);
y2 = y(2);
x3 = x(3);
y3 = y(3);
x4 = x(4);
y4 = y(4);

%output image coordinates
a1 = x1;
b1 = y1;
a2 = x2;
b2 = y1;
a3 = x3;
b3 = y3;
a4 = x4;
b4 = y3;

%we need 8 equations
syms e1 e2 e3 e4 e5 e6 e7 h11 h12 h13 h21 h22 h23 h31 h32

e1 = (a1*h11 + b1*h12 + h13)/(a1*h31 + b1*h32 + 1) == x1;
e2 = (a1*h21 + b1*h22 + h23)/(a1*h31 + b1*h32 + 1) == y1;


e3 = (a2*h11 + b2*h12 + h13)/(a2*h31 + b2*h32 + 1) == x2;
e4 = (a2*h21 + b2*h22 + h23)/(a2*h31 + b2*h32 + 1) == y2;


e5 = (a3*h11 + b3*h12 + h13)/(a3*h31 + b3*h32 + 1)== x3;
e6 = (a3*h21 + b3*h22 + h23)/(a3*h31 + b3*h32 + 1) == y3;


e7 = (a4*h11 + b4*h12 + h13)/(a4*h31 + b4*h32 + 1) == x4;
e8 = (a4*h21 + b4*h22 + h23)/(a4*h31 + b4*h32 + 1) == y4;

%solvng the equations
sol = solve([e1, e2, e3, e4, e5, e6, e7, e8], [h11, h12, h13, h21, h22, h23, h31, h32]);
h_11 = sol.h11;
h_12 = sol.h12;
h_13 = sol.h13;

h_21 = sol.h21;
h_22 = sol.h22;
h_23 = sol.h23;

h_31 = sol.h31;
h_32 = sol.h32;
h_33 = 1;

%homography matrix
h = [h_11, h_12, h_13; h_21, h_22, h_23; h_31, h_32, h_33];

[r c t] = size(img);
img_out = zeros(size(img));

%getting the final output image
for i=1:r
    for j=1:c
        initial_coordinates = [i;j;1];
        final_coordinates = h*initial_coordinates;
        %incase h is not 1
        final_image_coordinates = final_coordinates/final_coordinates(3,1);
        %image coordinates can't be -ve
        if (final_image_coordinates(1,1)<0 || final_image_coordinates(2,1)<0 || final_image_coordinates(3,1)<0)
            continue;
        else
            %blocking effect
            img_out(round(1 + final_image_coordinates(1,1)), round(1 + final_image_coordinates(2,1))) = img(i, j);
        end
    end
end

figure
imshow(img_out);












