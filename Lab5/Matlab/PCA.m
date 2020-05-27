%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grekousis G. 2020. Spatial Analysis Theory and Practice. Describe-Explore-Explain through GIS.
% Cambridge University Press. ISBN: 9781108614528. 
% https://www.cambridge.org/core/books/spatial-analysis-methods-and-practice/4C135005A621335D06CC63EFF17E3913#
%                   
%                Principal Component Analysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script performs Principal Component Analysis (PCA)for 27 variables of 64
% postcodes

% Files stored in \BookLabs\Lab5\Matlab
% Matlab flles: PCA.m (this file), PCA.mat stores the dataset

load PCA.mat

%Data stores the 27 variables for the 64 postcodes
%VariableName stores the name of the variables 

% First, create a simple boxplot to inspect variables' variance and if standardization is needed.
% Calculate pairwise correlation to quick inspect for relations between variables
f1=figure; 
boxplot(Data,'orientation','horizontal','labels',VariableNames);
C = corr(Data,Data);
%%%%%%%%%
%Step1. Standardize dataset
Z = zscore(Data); 

%Step2. Compute a) the eigenvectors (loadings of principal components), b) the principle component scores and c) the eigenvalues  - variance (latents).
[coefs,scores,variances,t2] = princomp(Z);
% Calculate percent explained (PCA command calcualtes it directly)
percent_explained = 100*variances/sum(variances);
%Caclulate the most extrem observation
[st2,index] = sort(t2,'descend'); % sort in descending order
extreme = index(1);
PostcodeNames(extreme,:)

%Step 3. Select the number of principle components to keep by constructing a scree plot. 
f2=figure; 
pareto(percent_explained)
xlabel('Principal Component')
ylabel('Cumulative Variance Explained (%)')

%Step 5. Create scatter plots of the first two principal components. [Matlab command: scatter]
f3=figure;
scatter(scores(:,1),scores(:,2), 'filled')
xlabel('Principal Component 1')
ylabel('Principal Component 2')
%Plot names of postcodes over points
gname(PostcodeNames);

%Step 6. Map scores in geographical space by joining scores to ArcGIS
%Not performed here.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
