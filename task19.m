
% James Nguyen
% 997332917 
% A01 
% No collaborators 
%Project 1
%Task 19:
clc;
clear;
load weather.mat
average_yearly_solar_insolation=mean(solar,2);
average_yearly_wind_speed=mean(wind,2);
average_yearly_precip=mean(precip,2);
solar_data_descending=(sort(average_yearly_solar_insolation,'descend'));
wind_data_descending=(sort(average_yearly_wind_speed,'descend'));
precip_data_descending=(sort(average_yearly_precip,'descend'));

filename='output_rank.txt';
fid=fopen(filename,'w');
fprintf(fid,'City                           Solar Rank          Wind Rank      Precipitation Rank \r\n \r\n \r\n');

%Remove repeated values in the solar_data_descending
solar_string_comparison=num2str(solar_data_descending);
remove_index=[];
a=0;
for nsolar=2:length(average_yearly_solar_insolation)
    a=strcmp(solar_string_comparison(nsolar,:),solar_string_comparison(nsolar-1,:));
    if a ==1
        remove_index(nsolar)=nsolar;
    end
end
remove_zeros_index=find(remove_index==0);
remove_index(remove_zeros_index)=[];
solar_data_descending(remove_index)=[];

%Remove repeated values in the wind_data_descending vector
wind_string_comparison=num2str(wind_data_descending);
remove_index2=[];
b=0;
for nwind=2:length(average_yearly_wind_speed)
    b=strcmp(wind_string_comparison(nwind,:),wind_string_comparison(nwind-1,:));
    if b ==1
        remove_index2(nwind)=nwind;
    end
end
remove_zeros_index2=find(remove_index2==0);
remove_index2(remove_zeros_index2)=[];
wind_data_descending(remove_index2)=[];

%Remove repeated values in the precip_data_descending vector
precip_string_comparison=num2str(precip_data_descending);
remove_index3=[];
c=0;
for nprecip=2:length(average_yearly_precip)
    c=strcmp(precip_string_comparison(nprecip,:),precip_string_comparison(nprecip-1,:));
    if c ==1
        remove_index3(nprecip)=nprecip;
    end
end
remove_zeros_index3=find(remove_index3==0);
remove_index3(remove_zeros_index3)=[];
precip_data_descending(remove_index3)=[];
reply=input('Please choose an overall structure: sun, rain, air. \n');

%%
if strcmp(reply,'sun')
%Rankings if Solar is chosen as main structure:
solar_row_position_vector=[];
precip_with_solar_main_vector=[];
wind_speed_with_solar_main_vector=[];
solar_rank_vector=[1:length(average_yearly_solar_insolation)]';

for n=1:length(solar_data_descending)
solar_row_position=find(solar_data_descending(n)==average_yearly_solar_insolation);
solar_row_position_vector=vertcat(solar_row_position_vector,solar_row_position);
precip_with_solar_main_vector_a=average_yearly_precip(solar_row_position);
precip_with_solar_main_vector=vertcat(precip_with_solar_main_vector,precip_with_solar_main_vector_a);
wind_speed_with_solar_main_vector_a=average_yearly_wind_speed(solar_row_position);
wind_speed_with_solar_main_vector=vertcat(wind_speed_with_solar_main_vector,wind_speed_with_solar_main_vector_a);
end

precip_with_solar_main_vector_rank=[];
wind_speed_with_solar_main_vector_rank=[];

for n=1:length(precip_with_solar_main_vector)
    precip_with_solar_main_vector_rank_a=find(precip_with_solar_main_vector(n)==precip_data_descending);
    precip_with_solar_main_vector_rank=vertcat(precip_with_solar_main_vector_rank,precip_with_solar_main_vector_rank_a);
    wind_speed_with_solar_main_vector_rank_a=find(wind_speed_with_solar_main_vector(n)==wind_data_descending);
    wind_speed_with_solar_main_vector_rank=vertcat(wind_speed_with_solar_main_vector_rank,wind_speed_with_solar_main_vector_rank_a);
end
%Find the city vector for the solar case:
city_vector_1=[];
for n=1:length(solar_row_position_vector)
    city_vector_1a=city(solar_row_position_vector(n),:);
    city_vector_1=vertcat(city_vector_1,city_vector_1a);
end
for n1=1:53
    fprintf(fid,'%s                    %G                    %G                    %G \r\n \r\n \r\n',city_vector_1(n1,:),solar_rank_vector(n1,:),wind_speed_with_solar_main_vector_rank(n1,:),precip_with_solar_main_vector_rank(n1,:));
end
fclose(fid);

end
%%
if strcmp(reply,'air')
%Rankings If Wind data is chosen as overall structure:
wind_row_position_vector=[];
precip_with_wind_main_vector=[];
solar_with_wind_main_vector=[];
wind_rank_vector=[1:length(average_yearly_wind_speed)]';

for n=1:length(wind_data_descending)
wind_row_position=find(wind_data_descending(n)==average_yearly_wind_speed);
wind_row_position_vector=vertcat(wind_row_position_vector,wind_row_position);
precip_with_wind_main_vector_a=average_yearly_precip(wind_row_position);
precip_with_wind_main_vector=vertcat(precip_with_wind_main_vector,precip_with_wind_main_vector_a);
solar_with_wind_main_vector_a=average_yearly_solar_insolation(wind_row_position);
solar_with_wind_main_vector=vertcat(solar_with_wind_main_vector,solar_with_wind_main_vector_a);
end

precip_with_wind_main_vector_rank=[];
solar_with_wind_main_vector_rank=[];

for n=1:length(precip_with_wind_main_vector)
    precip_with_wind_main_vector_rank_a=find(precip_with_wind_main_vector(n)==precip_data_descending);
    precip_with_wind_main_vector_rank=vertcat(precip_with_wind_main_vector_rank,precip_with_wind_main_vector_rank_a);
    solar_with_wind_main_vector_rank_a=find(solar_with_wind_main_vector(n)==solar_data_descending);
    solar_with_wind_main_vector_rank=vertcat(solar_with_wind_main_vector_rank,solar_with_wind_main_vector_rank_a);
end
%Find the city vector for the wind case
city_vector_2=[];
for n=1:length(wind_row_position_vector)
    city_vector_2a=city(wind_row_position_vector(n),:);
    city_vector_2=vertcat(city_vector_2,city_vector_2a);
end
for n2=1:53
    fprintf(fid,'%s                    %G                    %G                    %G \r\n \r\n \r\n',city_vector_2(n2,:),solar_with_wind_main_vector_rank(n2,:),wind_rank_vector(n2,:),precip_with_wind_main_vector_rank(n2,:));
end
fclose(fid);
end
%%
if strcmp(reply,'rain')
%Rankings if Precip Data is chosen as overall structure:
precip_row_position_vector=[];
wind_with_precip_main_vector=[];
solar_with_precip_main_vector=[];
precip_rank_vector=[1:length(average_yearly_precip)]';

for n=1:length(precip_data_descending)
    precip_row_position=find(precip_data_descending(n)==average_yearly_precip);
    precip_row_position_vector=vertcat(precip_row_position_vector,precip_row_position);
    wind_with_precip_main_vector_a=average_yearly_wind_speed(precip_row_position);
    wind_with_precip_main_vector=vertcat(wind_with_precip_main_vector,wind_with_precip_main_vector_a);
    solar_with_precip_main_vector_a=average_yearly_solar_insolation(precip_row_position);
    solar_with_precip_main_vector=vertcat(solar_with_precip_main_vector,solar_with_precip_main_vector_a);
end

wind_with_precip_main_vector_rank=[];
solar_with_precip_main_vector_rank=[];

for n=1:length(wind_with_precip_main_vector);
    wind_with_precip_main_vector_rank_a=find(wind_with_precip_main_vector(n)==wind_data_descending);
    wind_with_precip_main_vector_rank=vertcat(wind_with_precip_main_vector_rank,wind_with_precip_main_vector_rank_a);
    solar_with_precip_main_vector_rank_a=find(solar_with_precip_main_vector(n)==solar_data_descending);
    solar_with_precip_main_vector_rank=vertcat(solar_with_precip_main_vector_rank,solar_with_precip_main_vector_rank_a);
end
%Cities vector for Precip Data if chosen as primary:
%The cities vector can be obtained by using the 'X'_row_position_vector
city_vector_3=[];
for n=1:length(precip_row_position_vector)
    city_vector_3a=city(precip_row_position_vector(n),:);
    city_vector_3=vertcat(city_vector_3,city_vector_3a);
end

for n3=1:53
    fprintf(fid,'%s                    %G                    %G                    %G \r\n \r\n \r\n',city_vector_3(n3,:),solar_with_precip_main_vector_rank(n3,:),wind_with_precip_main_vector_rank(n3,:),precip_rank_vector(n3,:));
end
fclose(fid);
end
    