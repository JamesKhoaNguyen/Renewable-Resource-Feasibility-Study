%James Nguyen
%997332917 
%A01 
%No collaborators 
%Project 1
function scalar_output=sum_square(x,y)
%calculates the sum of the product of x and y subtracted by the the product
%of the sum of x and the sum of y divided by the size of the vector x
%Inputs:x,y-two vector inputs
%Outputs: scalar_output-difference of the scalar sum of the product of x
%and y and the scalar product of the sums of x and y divided by the size of
%vector x
product_of_x_and_y_elemental=(x.*y);
%product_of_x_and_y_elemental could be returned as a scalar or vector or
%matrix
%to account for matrixes of Nth dimension,take the sum of all the rows
%within the Nth dimension matrix
sum_of_products_semi_final=sum(product_of_x_and_y_elemental,2);
%the previous code returns a matrix of N rows but only one column, so now
%sum up the whole column to get a scalar
%do similar step for the 'x' data 
sum_of_x_semi_final=sum(x,2);
sum_of_y_semi_final=sum(y,2);
product_of_x_and_y_sums=sum_of_x_semi_final.*sum_of_y_semi_final;
n=length(x);
scalar_output=sum_of_products_semi_final-((product_of_x_and_y_sums)./n);