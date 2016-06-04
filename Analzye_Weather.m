% James Nguyen
% 997332917 
% A01 
% No collaborators 
% 
%%
clc;
clear;
load weather.mat; % load the database containing data in the given spreadsheet 

%Task 1:
%find all unique states
%Example: state(1,1)+state(1,2)= 141 ('A'+'L'=141)
% if state(2,1)+state(2,2)=141 also, then remove elements state(2,1) and
% state(2,2)

current_sum_vector=zeros(1,54);%preallocation of three vectors to save time
previous_sum_vector=(zeros(1,54));
repeat_states_vector=(zeros(1,54));

for r=(1:54);%for row index 1 to 54
    previous_sum = state(r,1)+ state(r,2);%the sum of the value of the strings that make up each state starting with the first
    previous_sum_vector(r)=previous_sum;%assign those values to the previous_sum_vector for comparison with current_sum_vector
end
for r=(1:53);%for row index 1 to 53, it's 1-53 instead of 1-54 because the firs item of orginal matrix states
    %has nothing to compare to. For instance, in this case the first state
    %in matrix 'state' is 'AL' which has no previous element to compare to.
    current_sum = state(r+1,1)+ state(r+1,2);%current_sum starts off at second element of the original 'states'
    %matrix in order to line up with the first element of
    %previous_sum_vector in order to do comparison
    current_sum_vector(r)=current_sum;%note that the last element of current
    %_sum_vector is 0 but it doesn't matter because the last element of the
    %original 'states' matrix isn't a repeat so 0 compared to 176 is a
    %unique element anyway
end
repeat_states_vector=(previous_sum_vector==current_sum_vector);%this vector
%contains all the locations in which original matrix 'states' contains
%repeats
[z c]=size(state);%assign size of state matrix to [z c] where z represents
%rows and c represents columns. z is used because r is already used up.
unique_states=z-sum(repeat_states_vector);%the amount of unique states
%is equal to the original 'state' matrix's number of rows subtracted by the
%sum of the repeat_states_vector
fprintf('Task 1: In total, %G unique states exist in the database \n \n \n',unique_states);



%%
%Task 2:
%Problem Description: Find and display the city with the longest name. 
%(Do not count the blank spaces. Only count upper and lower case letters )  
%You may use a loop in this task.

empty_space=(city==(' ')); %find where city has empty space and assign to 
%vector empty_space
total_empty_space=sum(empty_space,2);%take the sum of total empty space
%per row and assign to total_empty_space vector
rows1a= find(total_empty_space==min(total_empty_space));%find the row number
%in which vector total_empty_space is minimum. The row position of the minimum of this vector
%is the row position of the maximum character length city in the 'city'
%matrix.
longest_city_names=[city(rows1a,:)];%find longest city names in 'city' matrix
longest_city_names_transposed=longest_city_names';

[rows1b columns2]=size(city);%find row and column size of 'city' matrix
longest_character_length= columns2 - min(total_empty_space);%The column number is 14-2= 12
fprintf('Task 2:%s have the longest names. Each one has %G characters \n \n \n',longest_city_names_transposed,longest_character_length);


%%
%Task 3:
%Problem Description: Which city experiences the most wind in July?
rows3=find(wind(:,7)==max(wind(:,7)));%find where wind is maximum in July
most_wind_city=city(rows3,:);%use rows3 to find the corresponding city
fprintf('Task 3:%s experiences the most wind in July.\n \n \n',most_wind_city);


%%
%Task 4:
%Problem Description: Which city experiences the most wind (average yearly wind speed) 
%throughout the 12 months? The least?
mean_wind=mean(wind,2);%find the mean for each row of the 'wind' matrix where each row corresponds to a city
most_mean_wind=max(mean_wind);%find the max out of the mean_wind matrix
rows4=find(mean_wind==max(mean_wind));%assign the row position of that max to rows4
most_mean_wind_city=strtrim(city(rows4,:));%the city that has the most mean wind is located through indexing
most_mean_wind_city_transposed=most_mean_wind_city';
least_mean_wind=min(mean_wind);%find the minimum out of the mean_wind matrix
rows5=find(mean_wind==min(mean_wind));%assign the row position of the minimum of matrix 'mean-wind' to rows5
least_mean_wind_city=strtrim(city(rows5,:));%the city that has the lowest mean wind is located through indexing
least_mean_wind_city_transposed=least_mean_wind_city';
fprintf('Task 4:%s experiences the most wind while %s experiences the least wind.\n \n \n',most_mean_wind_city_transposed,least_mean_wind_city_transposed);


%%
%Task 5:
%Problem Description: What percentage of cities has average yearly wind speed greater than 8 
%miles per hour? 
rows6=find(mean_wind>8);%find the row positions in which where mean wind is greater than 8 within the vector 'mean_wind'
greater_than_8_mile_wind_city=city(rows6,:);%use rows6 as the row index for the cities in matrix 'city'
[rows7 columns7]=size(greater_than_8_mile_wind_city);%find size of the particular matrix and assign to it rows7 and columns7
percentage_greater_than_8_mile_wind=(rows7/54)*100;%use row7 as a way to count the total amount of cities that have more than 8 mph speeds and
%calculate the percentage
fprintf('Task 5: %5.2f percent of cities have yearly wind speed greater than 8 mph. \n \n \n',percentage_greater_than_8_mile_wind);


%%
%Task 6:
%Problem Description: Which city has the highest percentage of months that have wind speed 
%greater than 8 miles per hour? What is that percentage? You may use loops to help you solve 
%this problem. 
%speed of the month= the wind speed for that month and in this case it acts
%a counter to keep track of all months in which that particular city had
%wind speeds greater than 8 mph.
%index1=basically the row index of the 'wind' matrix
%index1a=basically the column index of the 'wind' matrix
speed_of_the_month_percentage_vector=[zeros(1,54)];%preallocate for speed
for index1=[1:54];
    speed_of_the_month=0;%initial value of number of cities with greater than 8 mile winds initially equal to zero
    % and is reset everytime the index1 value changes in order to prevent
    % errors with code
    for index1a=[1:12];%the secondary index (the second for loop is where all the detail is done per month per city)
        if wind(index1,index1a)>8;%if the wind speed is greater than 8 mph
            speed_of_the_month=speed_of_the_month + 1;%add 1 to the number of months in which wind speed for that city in which index1 refers to is 
            %greater than eight
        end
        speed_of_the_month_percentage_vector(index1)= speed_of_the_month/12;%find the month percentage of months greater than 8 mph 
    end
end
highest_percentage_by_month=max(speed_of_the_month_percentage_vector)*100;%finds the max value of percentage of months greater than 8 mph out of
%all cities
rows8=find(speed_of_the_month_percentage_vector'==max(speed_of_the_month_percentage_vector));%find where the vector 'speed of the month percentage
%vector is equal to the max value and assign that value to rows8
cities_greater_than_8_mile_wind_percentage_by_month=strtrim(city(rows8,:));%use rows8 as row index that finds the cities in which the max percentages belong to
cities_greater_than_8_mile_wind_percentage_by_month_transposed=cities_greater_than_8_mile_wind_percentage_by_month';
boston1=cities_greater_than_8_mile_wind_percentage_by_month_transposed(:,1);
casper1=cities_greater_than_8_mile_wind_percentage_by_month_transposed(:,2);
fprintf('Task 6:%s and %s have the highest percentage of months with wind speed greater than 8 miles per hour. %-5.2f percent \n \n \n',boston1,casper1, highest_percentage_by_month)


%%
%Task 7:
%Problem Description:
%Which city experiences the greatest total amount of sunlight in a year? 
%Which city experiences the greatest amount of sunlight in August? (Don’t forget to account 
%for land area) 
%remember that solar energy is in kW per square meter
year_total_sunlight_rate_per_city=sum(solar,2);%the year total of sunlight per city 
%sums are computed horizontally so basically computed by row where each
%row is city
area_converted_to_square_meters=area.*1000000;
year_total_sunlight_per_city_with_area=year_total_sunlight_rate_per_city.*area_converted_to_square_meters;%the total amount that comes in is dependent
%upon the month. The rates for each month for each city are given by the
%solar data sheet. Therefore the area of the land is not the changing
%factor. Therefore by unit analysis the solar rate gives (kW/square meter)
%and if you multiply the rate by the total area of the city, you get the
%total amount of kW for that city. The rates vary month by month and place
%by place. 
rows9=find(year_total_sunlight_per_city_with_area==max(year_total_sunlight_per_city_with_area));%find the row position of the max value of the vector
% 'year_total_sunlight_per_city_with_area
most_year_sunlight_city=strtrim(city(rows9,:));%use that row position in the previous
most_year_sunlight_city_transposed=most_year_sunlight_city';
%computation in order to find the row position within 'city' matrix
august_total_sunlight=(solar(:,8));%the solar rate per city in the month of august
august_total_sunlight_with_area=august_total_sunlight.*area_converted_to_square_meters; %the total energy
%per city is given by the equation in which the units would kW
rows10=find(august_total_sunlight_with_area==max(august_total_sunlight_with_area));%assign the row
%position of the max value of the previous vector to rows10
most_august_sunlight_city=strtrim(city(rows10,:));%use the row position to find the corresponding city which is Anchorage in this case
most_august_sunlight_city_transposed=most_august_sunlight_city';
fprintf('Task 7: %s experiences the greatest total amount of sunlight in a year. %s has the most sunlight in August.\n \n \n',most_year_sunlight_city_transposed,most_august_sunlight_city_transposed);



%%
%Task 8:
%Problem Description:
%Assuming 40 percent of the land area in a city is completely covered in
%100 percent efficient solar panels. Which city can potentially produce the 
%most solar energy in July?
%remember that solar energy is in kW per square meter
july_total_sunlight=(solar(:,7));%total july solar rates 
forty_percent_area=0.40.*(area_converted_to_square_meters);%get 40 percent of the area
july_total_sunlight_with_area = july_total_sunlight.*forty_percent_area;%gives you
%the total solar energy produced for that city 
rows11=find(july_total_sunlight_with_area==max(july_total_sunlight_with_area));%row indexing to find corresponding city
most_july_efficient_solar_city = strtrim(city(rows11,:));%use rows11 as index to find corresponding city
most_july_efficient_solar_city_transposed=most_july_efficient_solar_city';
fprintf('Task 8:%s can potentially produce the most solar energy in July. \n \n \n',most_july_efficient_solar_city_transposed);



%%
%Task 9:
%Assuming 40% of the land area in a city is completely covered in 100% 
%efficient solar panels. Each solar panel is 60 square meters and produces 1kW. Which city has 
%the greatest solar power available in January? 
%remember that solar energy is in kW per square meter
%(kW/square meter)(square meter)
january_total_sunlight=solar(:,1);%total solar rates for january per city
january_total_sunlight_with_area=january_total_sunlight.*forty_percent_area;%the solar energy output for each city in month of January
rows12=find(january_total_sunlight_with_area==max(january_total_sunlight_with_area));%row index for corresponding city
most_january_solar_city=strtrim(city(rows12,:));%find corresponding city which is Phoenix in this case
most_january_solar_city_transposed=most_january_solar_city';
fprintf('Task 9:%s can has the greatest solar power available in January.\n \n \n',most_january_solar_city_transposed);
%(kW/square meter) is what the solar data represents, it shows
%the cities have this much sunlight per meter where sunlight is measured in
%kW. The solar data does not take into account that only 40 percent of the
%land solar panels. 0.40*area gives you 40 percent of the land. So first
%multiply the solar rate given by the solar data sheet by the amount of
%land that is available and that gives you the total solar energy that is
%actually usuable for that city. (kW/square meter)(0.40*square meter) is
%the amount of incoming sunlight you have for forty meters per city. The
%solar panels are 100 percent efficient so there is a one-to-one ratio of
%energy incoming in that is used. Meaning whatever comes in is all used up.
%Basically you need to figure out how many solar panels there are in each
%city. 
%Total area available is (0.40*area) and the number of solar panels that
%can fit on the land is given by (0.40*area)/60=_ solar panels
%The total energy that is produced is dependent on the amount of sunlight
%rate for January and the amount of solar panels. 
%Total energy is given by (kW/square meter) and solar panels is given by 
%solar panels(60 square meters/1 solar panel)(sunlight rate=kW/square
%meter).



%%
%Task 10:
%Strong wind (average yearly wind speed greater than 3mph) damages solar 
%panels. List the top three cities where solar panels are most likely to be damaged. Assume 
%only cities with average yearly solar insolation greater than 4 kilo Watts per square meter, 
%and have land area greater than 300 square Kilometers have solar panels installed. 
average_yearly_solar_insolation=mean(solar,2);%get the average yearly solar insolation by dividing the total year insolation
%by the number of months which is twelve 
average_yearly_solar_insolation_greater_than_4=average_yearly_solar_insolation>4;%obtain a binary vector that contains
%all of the average yearly insolations that are greater than 4 kW
area_greater_than_300=area>300;%obtain a binary vector that contains all the city areas that are greater than 300 square meters
mean_wind_greater_than_3=mean_wind>3;%obtain a binary vector where all mean_wind are greater than 3 mph
all_three_conditions_met=mean_wind_greater_than_3+area_greater_than_300+average_yearly_solar_insolation_greater_than_4;%obtain
%a matrix where all three conditions are met. This occurs wherever the
%'all_three conditions met' vector is equal to 3.
rows13=find(all_three_conditions_met==3);%find the row positions in which the 'all_three_conditions_met' matrix is equal to 3 and 
%assign to rows13
%at this point you have all the row positions of the cities that meet the
%condition and now it's time to rank them. In order to rank them, you rank
%by the wind speed. 
mean_wind_sub=mean_wind(rows13,1);%using the previous rows13 index, find the qualifying cities' corresponding wind speeds and assign to the 
%matrix 'mean_wind_sub'
mean_wind_sub_descending=sort(mean_wind_sub,'descend');%use the 'descend' sort function in order to list in 'desceding order' of the matrix 'mean_wind
%_sub
top_3=mean_wind_sub_descending((1:3),1);%to find the top three cities by wind speed, extract the top 3 from matrix 'mean_wind_sub' and assign these
%top 3 values of wind speed into the 'top_3' matrix; the first item of this
%matrix would indicate the wind speed of the most vulnerable city and the
%second item would indicate the second most vulnerable city and so on. 
most_vulnerable_city_index=find(mean_wind==top_3(1));%in order to find index that you will use to find city within the 'city' matrix, you would
%find where the 'mean_wind' matrix is equal to 1st element of the 'top_3'
%vector which would give you the index of the most vulnerable city 
most_vulnerable_city=strtrim(city(most_vulnerable_city_index,:));%find the most_vulnerable_city with the previously found index
most_vulnerable_city_transposed=most_vulnerable_city';
second_most_vulnerable_city_index=find(mean_wind==top_3(2));% similar to previous steps
second_most_vulnerable_city=strtrim(city(second_most_vulnerable_city_index,:));
second_most_vulnerable_city_transposed=second_most_vulnerable_city';
third_most_vulnerable_city_index=find(mean_wind==top_3(3));
third_most_vulnerable_city=strtrim(city(third_most_vulnerable_city_index,:));
third_most_vulnerable_city_transposed=third_most_vulnerable_city';
fprintf('Task 10: In order of likeliness to damage solar panels: %s, %s, %s. \n \n \n',most_vulnerable_city_transposed,second_most_vulnerable_city_transposed,third_most_vulnerable_city_transposed);


%%
%Task 11:
%A rainwater collection system is used in each city to recycle rainwater. 
%Assuming 5% of the land area of each city is covered with rainwater collection system, which 
%city collects the most rain in February? How about in August?
%keep in mind that 'precip' data is given in inches
%the area of a city is given in square meters 
%conversion is 1 inch= 0.0254 meters
precipitation_february=(precip(:,2)).*(0.0254);%precipitation in february mulitplied by 
%0.0254 in order to convert to meters 
%Assuming that rainwater collection system is 100 percent efficient,the
%amount of rain water collected will be the amount of rain as told by the
%'precip' matrix so basically the amount of height that the rain gives is
%given by 'precip' data. The area in which you have to work with is 5
%percent of the area of the city. 
five_percent_area=0.05.*area_converted_to_square_meters;%five percent of the area has a rainwater collection system
rain_water_volume_february=five_percent_area.*precipitation_february;%obtain
%a matrix that contains the volume of rain water per city with area 5
%percent area accounted for
rows14=find(rain_water_volume_february==max(rain_water_volume_february));%row 
%index for the city with the most rain water volume 
most_february_rain_water_volume_city=strtrim(city(rows14,:));%put the row index into 'city' matrix to find the city
most_february_rain_water_volume_city_transposed=most_february_rain_water_volume_city';
precipitation_august=(precip(:,8)).*(0.0254);%repeat steps for the month of August
rain_water_volume_august=five_percent_area.*precipitation_august;
rows15=find(rain_water_volume_august==max(rain_water_volume_august));
most_august_rain_water_volume=strtrim(city(rows15,:));
most_august_rain_water_volume_transposed=most_august_rain_water_volume';
fprintf('Task 11: %s collects the most rain in February while %s collects the most rain in August. \n \n \n',most_february_rain_water_volume_city_transposed,most_august_rain_water_volume_transposed);


%%
%Task 12:
%Strong wind reduces the amount of collected rainwater. Assuming monthly 
%wind speed below 3mph reduces the amount collected that month by 5%, monthly wind 
%speed from 3 to 5 mph reduces the collection amountby 10%, and monthly wind speed above 
%5 mph reduces the collection amount by 40%. Which city collect the most rain water in a 
%year? 

%find out which cities have wind speeds below 3mph
wind_speeds_below_3mph_binary=(wind<3);
%find out which cities have wind speeds from 3 to 5 mph
wind_speeds_from_3mph_to_5mph_binary=(wind>=3 & wind <=5);
%find out which cities have wind speeds greater than 5mph
wind_speeds_greater_than_5mph_binary=(wind>5);

%Months with wind speeds less than 3mph
%work with the cities that have wind speeds below 3mph first 
%the best way is to deal with all circumstances individually and then add
%up for the final matrix
%mulitply the wind_speeds_below_3mph_binary matrix element by element wise to the
%original matrix precip in order to get a matrix of only precipitation that
%correspond to months that have less than 3mph wind and all other values will be zero.
total_precipitation_for_wind_less_than_3mph=wind_speeds_below_3mph_binary.*precip;
%now evaluate how much rain is collected for those months of those cities
%all described in the previous matrix. In the less than 3mph wind case, the
%total rain for that particular month for that particular city is described
%by the equation precipitation for that month=precipitation for that
%month-0.05.*preicipation for that month. 
reduced_precipitation_for_wind_less_than_3mph=total_precipitation_for_wind_less_than_3mph-0.05.*total_precipitation_for_wind_less_than_3mph;

%Months with wind speeds==3 & <=5
%go onto compute the total rain collection for the months of each city
%where the wind speeds are from 3 to 5 mph
total_precipitation_for_wind_from_3mph_to_5mph=wind_speeds_from_3mph_to_5mph_binary.*precip;
%the results are displayed as a matrix again
%obtain the matrix that contains the total rain precipitation with
%10 percent reduction factor
reduced_precipitation_for_wind_from_3mph_to_5mph=total_precipitation_for_wind_from_3mph_to_5mph-0.10.*total_precipitation_for_wind_from_3mph_to_5mph;

%Months with wind speeds>5mph
%follow through with similar steps from previous steps
total_precipitation_for_wind_speed_greater_than_5mph=wind_speeds_greater_than_5mph_binary.*precip;
reduced_precipitation_for_wind_speed_greater_than_5mph=total_precipitation_for_wind_speed_greater_than_5mph-0.40.*total_precipitation_for_wind_speed_greater_than_5mph;

%Final total precipitation matrix with reduction factors incorporated
%Simply add all three matrixes element by element
total_yearly_precipitation_with_reduction_by_month=(reduced_precipitation_for_wind_less_than_3mph)+(reduced_precipitation_for_wind_from_3mph_to_5mph)+(reduced_precipitation_for_wind_speed_greater_than_5mph);

%At this point you have a matrix, but you need the yearly totals so sum up
%the rows of the total_yearly_precipitation_with_reduction matrix
total_yearly_precipitation_lump_total_by_city=sum(total_yearly_precipitation_with_reduction_by_month,2);
%Find the max of the lump_total precipitation vector and assign it to a row
%index variable
rows16=find(total_yearly_precipitation_lump_total_by_city==max(total_yearly_precipitation_lump_total_by_city));
%use that index variable to find the corresponding city
most_yearly_precipitation_city=strtrim(city(rows16,:));
most_yearly_precipitation_city_transposed=most_yearly_precipitation_city';
fprintf('Task 12: Accounting for loss due to strong wind, %s collects the most rainwater in a year. \n \n \n',most_yearly_precipitation_city_transposed);


%%
%Task 13
%Problem Description:
%Too much rain increases the probability that solar panels become 
%damaged. Specifically, cities with monthly precipitation above 3 inches are likely to have its 
%solar panels damaged. (Again assume only cities with average yearly solar radiation greater 
%than 4 kilo Watt per meter square have solar panels installed) 
%List the top three cities where solar panels are most likely to be damaged.

%retrieve the vector that indicates the cities with average yearly solar
%radiation greater than 4 kW and assign it to a row index variable 
cities_with_average_yearly_solar_insolation_greater_than_4_index = find(average_yearly_solar_insolation_greater_than_4);
%You now have the row positions of the cities that have greater than 4kW of
%solar insolation yearly
%next find all locations within the 'precip' matrix in which a particular
%city within a particular month has greater than 3 inches of precipitation
precipitation_greater_than_3_inches_binary=precip>3;
%now that you have all the places where precipitation is greater than 3
%inches, mulitply by the original 'precip' matrix in order to get all
%precip values greater than 3 with those less than 3 all equaling zero for
%our intents and purposes
preicipitation_greater_than_3_inches=precipitation_greater_than_3_inches_binary.*precip;
%sum the precipitation values greater than 3 inches by row and then you
%will have the totals of all values greater than 3 inches summed up for
%each city
total_precipitation_greater_than_3_inches=sum(preicipitation_greater_than_3_inches,2);
%extract the values that correspond to the cities that fufill the first
%prerequisite of 4kW per square meter of solar radiation and put into a
%matrix called 'top_3_precipitation'
top_3_precipitation=total_precipitation_greater_than_3_inches(cities_with_average_yearly_solar_insolation_greater_than_4_index,:);
%once the values are put into the top_3_precipitation matrix sort them by
%greatest to least
top_3_descending=sort(top_3_precipitation,'descend');
%find the row position of the city that has the corresponding total
%precipitation value of all values greater than 3 inches for that city
most_vulnerable_city_because_of_precipitation_index=find(top_3_descending(1)==total_precipitation_greater_than_3_inches);
%find the city that is most vulnerable
most_vulnerable_city_because_of_precipitation=strtrim(city(most_vulnerable_city_because_of_precipitation_index,:));
most_vulnerable_city_because_of_precipitation_transposed=most_vulnerable_city_because_of_precipitation';
%find the index of the second most vulnerable city
second_most_vulnerable_city_because_of_precipitation_index=find(top_3_descending(2)==total_precipitation_greater_than_3_inches);
%find the most vulnerable city
second_most_vulnerable_city_because_of_precipitation=strtrim(city(second_most_vulnerable_city_because_of_precipitation_index,:));
second_most_vulnerable_city_because_of_precipitation_transposed=second_most_vulnerable_city_because_of_precipitation';
%find the third most vulnerable city
third_most_vulnerable_city_because_of_precipitation_index=find(top_3_descending(3)==total_precipitation_greater_than_3_inches);
third_most_vulnerable_city_because_of_precipitation=strtrim(city(third_most_vulnerable_city_because_of_precipitation_index,:));
third_most_vulnerable_city_because_of_precipitation_transposed=third_most_vulnerable_city_because_of_precipitation';
fprintf('Task 13:In order to likeliness to have solar panels damaged due to rain: %s, %s, and %s. \n \n \n',most_vulnerable_city_because_of_precipitation_transposed,second_most_vulnerable_city_because_of_precipitation_transposed,third_most_vulnerable_city_because_of_precipitation_transposed);

%%
%Task 14:
%Assume a wind turbine can produce an average of 5000 kW of energy 
%each month if the average wind speed that month is greater than 3 miles per hour. Each wind 
%turbine takes up 10,000 square meters of area, and 7% of a city’s land area is covered in wind 
%turbines. Assume cities with average yearly solar radiation greater than 3 kW/square meter 
%have 100% efficient solar panels installed in 40% of its land area. Cities with wind power 
%greater than solar power should install wind turbines. How many cities should install wind 
%turbines? How many cities should install solar panels?
%1 wind turbine=5000 kWh each month if that month's wind speed is greater
%than 3mph
%therefore find the months of particular cities where wind speeds are
%greater than 3 mph
wind_speeds_greater_than_3mph_binary=wind>3;
%take the sum across the rows in order to make manipulation easier
wind_speeds_greater_than_3mph_binary_sum=sum(wind_speeds_greater_than_3mph_binary,2);
%at this point you have a binary matrix of wind speeds greater than 3mph
%the amount of wind turbines that are available for use for each city 
%dependent on how much land is available which in this case is only 7% of
%the city's land area. Convert the kilometer square to square meters and
%then take 7 percent of that land. Then multiply the (1 wind turbine/10,000
%square meters)
%1 km^2=1,000,000 m^2
seven_percent_of_area=0.07.*area;
number_of_wind_turbines_per_city=floor(seven_percent_of_area.*(1/10));
%now to find out how much energy is produced for each month of each
%particular city, multiply number_of_wind_turbines by a value of 5000
%because number of wind turbines is in units of wind turbines(5000kWh/1
%wind turbine gives you the total energy 
total_wind_turbine_energy_with_accounted_land_per_one_month=number_of_wind_turbines_per_city.*5000;
%to find out how much wind energy is produced yearly multiply this  matrix
%to the binary matrix as only this much energy per month is produced if the
%prerequisite of the wind speeds being greater than 3mph is met
total_wind_turbine_energy_with_accounted_land_yearly=total_wind_turbine_energy_with_accounted_land_per_one_month.*wind_speeds_greater_than_3mph_binary_sum;
%keep in mind that the total energy is now in kW
%next is to find the total solar insolation for each month
%find the cities where average yearly solar insolation is greater than 3
%kW/square meter
average_yearly_insolation_greater_than_3_binary=average_yearly_solar_insolation>3;
%now you have matrix with zeros and ones and you need to multiply the
%binary matrix by the original matrix in order to get a matrix with only
%mean solar insolation values greater than 3kW/square meter
average_yearly_insolation_greater_than_3=average_yearly_insolation_greater_than_3_binary.*average_yearly_solar_insolation;
%now you have a matrix that contains all mean solar insolation values
%greater than 3 kW/square meter
%it's time to find the total kW output for each city, and in order to do so
%multiply the average insolation values to each element by element to 40
%percent of the converted area in order to get (kW/square meter)*square
%meter =kW
forty_percent_area=area*0.40;
total_solar_energy_with_land_yearly=forty_percent_area.*average_yearly_insolation_greater_than_3;
%at this point you have the yearly outputs for solar and wind energy for
%a year for each city but the units are not the same. Convert both to
%joules and then compare in order to find out which cities actually install
%wind turbines. Only cities which have greater wind energy than solar
%energy wil install. 
%in order to make the units the same, kWh and kW will both be converted to
%joules
%1 Joules= 1000*kW*time; time in this case is kept consistent with the kWh
%1 Joules=1000*3600*kW=1000*3600*solar energy total
rows18=find(total_solar_energy_with_land_yearly<total_wind_turbine_energy_with_accounted_land_yearly);
cites_that_have_higher_wind_power=length(rows18);
total_solar_cities=total_solar_energy_with_land_yearly.*average_yearly_insolation_greater_than_3_binary;
total_solar_cities_number=length(total_solar_energy_with_land_yearly)-cites_that_have_higher_wind_power;
fprintf('Task 14:  %.0f cities should install wind turbines while %.0f cities should install solar panels. \n \n \n',cites_that_have_higher_wind_power,total_solar_cities_number);








%%
%Task 15:
%An increase in sustainable energy awareness causes the number of solar 
%panel arrays installed per month per household to increase. If 50% of the households 
%(assume 1 household has 3 persons) in all cities in the database decides to start utilizing solar 
%panels for their home today, how much total power relief can be achieved in August? 
%(Power relief is defined here to be the amount of power consumed each household, but not 
%supplied by the power grid) 
%Assume each household installs an average of 40 panels, and each panel produces 200 watts. 
%Assume the power demand of the households that utilize solar panels, is met. (They do not 
%need to draw power from the power grid. They are 100% off the grid.) 

%find the amount of households per city: 
%since the population vector is in units of people presumably and 1
%household is 3 people:
number_of_households_per_city=population.*(1/3);%units is households
%find 50 percent of the households of each city;
fifty_percent_of_households_per_city=0.50.*number_of_households_per_city;
total_power_output=fifty_percent_of_households_per_city.*40.*200;
total_power_output_per_month=total_power_output./12;
total_power_output_per_month_per_all_cities=sum(total_power_output_per_month)./1000000;
fprintf('Task 15: In total, all cities together achieve a power relief of %G mega watts in August. \n \n \n',total_power_output_per_month_per_all_cities);

%%
%Task 16:
%Write code to plot the solar and precipitation data for the 12 months, for 
%the following three cities on the same plot. Cities: Miami, Seattle, and Boston. One would
%expect that cities with high precipitation experiences low sunlight. 
%Your plot should be formatted using the following specifications: 
%1) plot the solar data using dashdot style lines, and the precipitation data using dotted style 
%lines, 
%2) plot data for Miami(it says San Francisco on Project Sheet, mistake) using the color Red,Seattle using Blue, and Boston using 
%Magenta, and 
%3) for all, use line width of 2.5. 

%Miami Solar and Precipitation Data:
months=[1:12];
miami_solar_data=solar(10,:);
miami_precip_data=precip(10,:);
plot(months,miami_solar_data,'LineWidth',2.5,'LineStyle','-.','Color','red');
hold on;
plot(months,miami_precip_data,'LineWidth',2.5,'LineStyle',':','Color','red');
hold on;

%Seattle Solar and Precipitation Data:
seattle_solar_data=solar(51,:);
seattle_precip_data=precip(51,:);
plot(months,seattle_solar_data,'LineWidth',2.5,'LineStyle','-.','Color','blue');
hold on;
plot(months,seattle_precip_data,'LineWidth',2.5,'LineStyle',':','Color','blue');
hold on;

%Boston Solar and Precipitation Data:
boston_solar_data=solar(20,:);
boston_precip_data=precip(20,:);
plot(months,boston_solar_data,'LineWidth',2.5,'LineStyle','-.','Color','magenta');
hold on;
plot(months,boston_precip_data,'LineWidth',2.5,'LineStyle',':','Color','magenta');
hold on;

%General Formatting:
xlabel('Month');
ylabel('Solar Insolation(kW per square meters) and Precipitation(inches)');
title('Solar Insolation and Precipitation of Miami, Seattle and Boston');


%%
%Task 18:
%The correlation between two datasets, x and y can be computed using the 
%formula below. Write code to find the top three cities whose correlation between solar and 
%precipitation data is closest to -1. Use the function you wrote in Task 17 to help you. 

%find the correlation between the two datasets for all cities
%choose arbitrarily 'x' to represent the solar data and 'y' to represent
%precipitation data
x=solar;
y=precip;
%to simplify things, set the numerator of the correlation equation as such
numerator=sum_square(x,y);
%to simplify things, set the denominator of the correlation equation as
%such
denominator=sum_square(x,x).*sum_square(y,y);
%the function to find correlation provided by the question
correlation_r=numerator./sqrt(denominator);
%Arrange in ascending order in order to determine top 3 correlations
%closest to negative one
descending_correlation_r=sort(correlation_r,'ascend');
%Get top 3 correlations closest to negative one
top_3_correlation_r_closest_to_negative_one=descending_correlation_r(1:3);
%Find the first closest city
closest_to_negative_one_city_index=find(top_3_correlation_r_closest_to_negative_one(1)==correlation_r);
closest_to_negative_one_city=strtrim(city(closest_to_negative_one_city_index,:));
%Then the second
second_closest_to_negative_one_city_index=find(top_3_correlation_r_closest_to_negative_one(2)==correlation_r);
second_closest_to_negative_one_city=strtrim(city(second_closest_to_negative_one_city_index,:));
%then the third
third_closest_to_negative_one_city_index=find(top_3_correlation_r_closest_to_negative_one(3)==correlation_r);
third_closest_to_negative_one_city=strtrim(city(third_closest_to_negative_one_city_index,:));
fprintf('Task 18: The top three cities whose correlation between solar and precipitation data is closest to -1 are (in descending order) : %s, %s, %s. \n \n \n',closest_to_negative_one_city,second_closest_to_negative_one_city,third_closest_to_negative_one_city);








































    
    
    
    