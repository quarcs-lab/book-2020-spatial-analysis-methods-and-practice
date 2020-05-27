%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grekousis G. 2020. Spatial Analysis Theory and Practice. Describe-Explore-Explain through GIS.
% Cambridge University Press. ISBN: 9781108614528. 
% https://www.cambridge.org/core/books/spatial-analysis-methods-and-practice/4C135005A621335D06CC63EFF17E3913#
%                   
%                  Multidimensional Scaling
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script performs Multidimensional Scaling (MDS) for 5 variables of seven
% islands

% Files stored in \BookLabs\Lab5\Matlab
% Matlab flles: MDS.m (this file), MDS.mat stores the dataset

load MDS.mat

%IslandsMDS stores the 5 variables of seven island
%IslandNames stores the name of the islands  

dissimilarities = pdist(zscore(IslandsMDS),'euclidean'); %Dissimilarities 
%calculates the pairwise distances among points of the standardized data matrix (IslandsMDS)  
%using Euclidean distance

[Y,stress] =mdscale(dissimilarities,2,'criterion','metricstress');

% 2 is set the number of dimensions that the original data will be reduced 
%using the goodness of fit criterion.  

plot(Y(:,1),Y(:,2),'o','LineWidth',2);

%Plot names of islands over points
gname(IslandNames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%