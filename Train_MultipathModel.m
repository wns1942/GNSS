function [Mdl] = Train_MultipathModel(elevation, azimuth, multipath)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Prgram name : compute_TravelTime
%  Description : This function computes the time the reciever has received
%  from the satellite signal transmission
%
%  System                 Subsystem    Block(source file)
%  --------------------   ---------    ---------------------
%  Train_MultipathModel                Train_MultipathModel.m
%
%  Revision history:Date  Author                              Version No
%  ---------------------  ----------------------------------  -----------
%  24.01.2022             Sejong Univ. Navigation System Lab  version 1.0
%
%      Input
%             elevation : Statellie elevation angle [rad]
%             azimuth   : Statellie azimuth angle [rad]
%             multipath : Extracted GNSS Multipath [m]
%      Output
%             Mdl : GNSS Multipath Estimator
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

multipath(find(elevation*180/pi < 15)) = 0;

idx = intersect(find(multipath ~= 0),intersect(find(elevation~=0),find(azimuth~=0)));

Xfit = [sin(azimuth(idx)) cos(elevation(idx)) elevation(idx)];
Y = multipath(idx_train);

Mdl = fitrsvm(Xfit,Y,'KernelFunction','gaussian');