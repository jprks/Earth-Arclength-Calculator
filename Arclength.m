% Title: Earth Arclength Calculator
% Author: James Emerson Parkus
% Date: 9/9/17
% Purpose: This script calculates the distance between two GPS locations,
% accounting for Earth curvature. 
%
% Error is 4%
%
% Assumptions:
% 1. Spherically Symmetric Earth
% 2. Greenwich-Longitude center
% 3. Equator is 0th degree of Latitiude
%
% ENCLOSE LOCATION NAMES WITH ' '

clc
clear
format short

%% Constants
rho = 6.37*10^6; % meters - Earth Radius

%% Units
unitless = '[-]';
metric_distance_unit = '[m]'; % meters
imperial_distance_unit = '[miles]'; % miles
angle_unit = '[deg]'; % degrees

%% Inputs
city_1 = input('Enter the name of the first location\n');
latitude_1 = input('Enter the latitude of the first city [xx.xxxx]\n');
longitude_1 = input('Enter the longitude of the first city [xx.xxxx]\n');

city_2 = input('Enter the name of the second location\n');
latitude_2 = input('Enter the latitude of the second city [xx.xxxx]\n');
longitude_2 = input('Enter the longitude of the second city [xx.xxxx]\n');

% % Test Locations
% latitude_1 = 43.088; % Rochester, NY, USA
% longitude_1 = -77.657;
% 
% latitude_2 = 48.5667; % Passau, Germany
% longitude_2 = 13.4319;
% % Real Distance = 4131.62 miles
% % Calculated Distance = 4264.47 miles
% % Error < 0.04 -> 4% 

%% Arclength Calculation
% longitude_1 = str2num(longitude_1_str);
% latitude_1 = str2num(latitude_1_str);
% 
% longitude_2 = str2num(longitude_2);
% latitude_2 = str2num(latitude_2);

arclength = Earth_Arclength(rho,longitude_1,latitude_1,longitude_2,latitude_2);

%% Display Results
linedivider ='--------';

result = {
    city_1,'','';
    'Longitude',longitude_1,angle_unit;
    'Latitude',latitude_1,angle_unit;
    '','','';
    city_2,'','';
    'Longitude',longitude_2,angle_unit;
    'Latitude',latitude_2,angle_unit;
    '','','';
    'Distance',arclength,metric_distance_unit;
    '',arclength*0.000621371,imperial_distance_unit;
    };

clc

display(result);

%% Arclength Function

function arclength = Earth_Arclength(rho,longitude_1,latitude_1,longitude_2,latitude_2)
theta_1 = longitude_1;
phi_1 = 180 - latitude_1;

theta_2 = longitude_2;
phi_2 = 180 - latitude_2;

% City 1 Vector Components
A(1) = rho*sin(deg2rad(phi_1))*cos(deg2rad(theta_1));
A(2) = rho*sin(deg2rad(phi_1))*sin(deg2rad(theta_1));
A(3) = rho*cos(deg2rad(phi_1));

% City 2 Vector Components
B(1) = rho*sin(deg2rad(phi_2))*cos(deg2rad(theta_2));
B(2) = rho*sin(deg2rad(phi_2))*sin(deg2rad(theta_2));
B(3) = rho*cos(deg2rad(phi_2));

% Calculating the connection vector
C = B - A;

%Calculating Vector Magnitudes
mag_A = sqrt(A(1)^2 + A(2)^2 + A(3)^2);
mag_B = sqrt(B(1)^2 + B(2)^2 + B(3)^2);
mag_C = sqrt(C(1)^2 + C(2)^2 + C(3)^2);

% Finding Separation Angle
omega = acos((mag_C^2 - mag_A^2 - mag_B^2)/(-2*mag_A*mag_B));

% Calculating Arclength
arclength = rho*omega;

end

%% Display Function

% Thanks to Philip Lindin for providing the display function from his TDU.m
% script
% https://github.com/runphilrun/TDU

function display(result)
[n,~]=size(result);
for i = 1:n
    fprintf('\n%24s\t%12f\t%s',result{i,:});
end
end