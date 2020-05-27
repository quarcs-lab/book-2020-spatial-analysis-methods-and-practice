%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grekousis G. 2020. Spatial Analysis Theory and Practice. Describe-Explore-Explain through GIS.
% Cambridge University Press. ISBN: 9781108614528. 
% https://www.cambridge.org/core/books/spatial-analysis-methods-and-practice/4C135005A621335D06CC63EFF17E3913#
%                  
%                Hierarchical clustering
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script performs hierarchical clustering for seven
% islands based on two variables

% Files stored in \BookLabs\Lab5\Matlab
% Matlab flles: HC.m (this file), MDS.mat stores the dataset

load MDS.mat

%Islands stores the 5 variables od seven island
%IslandNames stores the name of the islands  

%Plot values in scatterplot
scatter(Islands(:,1),Islands(:,2),'filled'); 
xlabel('Tourists (in hundred thousands)');
ylabel('Money spent (in thousand Euros)');

%Plot names of islands over points
gname(IslandNames);

%Calculate distance matrix using Euclidean distance
Dist = pdist(Islands);
%%Dist is a vector array. To view the distance matrix:
DistanceMatrix = squareform(Dist);
% Use Dist array
%Perform clustering with single linkage method
Z = linkage(Dist,'single');

%Plot the dendrogram
dendrogram(Z);
xlabel('Objects Ids');
ylabel('Distance value metric');
%Plot the dendrogram with labels
dendrogram(Z,'label',IslandNames);
xlabel('Objects Ids');
ylabel('Distance value metric');
%Calculate the optimal number of clusters 
%First, verify inconsistency 
I = inconsistent(Z);
%Second, select a cut-off value of inconsistency
T = cluster(Z,'cutoff',0.8);

%Verify cluster dissimilarity
c = cophenet(Z,Dist);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Apply clustering for different linkage method
%Select Ward's Linkage method
%Perform clustering with single linkage method
Z1 = linkage(Dist,'ward');
%and verify cluster dissimilarity
c1 = cophenet(Z1,Dist);
%Plot the dendrogram
dendrogram(Z1);
xlabel('Objects Ids');
ylabel('Distance value metric');
% Verify inconsistency 
I1 = inconsistent(Z1);
% Second, select a cut-off value of inconsistency
T1 = cluster(Z1,'cutoff',0.8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%