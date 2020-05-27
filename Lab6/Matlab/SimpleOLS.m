%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grekousis G. 2020. Spatial Analysis Theory and Practice. Describe-Explore-Explain through GIS.
% Cambridge University Press. ISBN: 9781108614528. 
% https://www.cambridge.org/core/books/spatial-analysis-methods-and-practice/4C135005A621335D06CC63EFF17E3913#
%                    
%                Simple Linear Regression (OLS) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Script performs simple OLS regression


% Files stored in \BookLabs\Lab6\Matlab
% Data stored in Regression.xls (Worksheet:Simple OLS)
% Matlab files: SimpleOLS.m (this file), SimpleOLS.mat stores the dataset

load SimpleOLS % Load data

%Simple Linear Regression (Dependent Y:Income. Independent X: Medical Expenses
tbl=table(X,Y,'VariableNames',{'MedExpenses','Income'}); %Input data (specified as a table or dataset array) and variables' names.
mdl=fitlm(tbl); %returns a linear model fit. By default, fitlm takes the last variable as the response variable.
anova(mdl,'summary') % ANOVA results summary
plot(mdl)% Plot observations, regression line, and confidence interval for mean Y(95%)
plotResiduals(mdl,'fitted')  %	Plot Residuals vs. fitted values to test homoscedasticity  
plotResiduals(mdl,'fitted','ResidualType','Standardized') %	Plot Standardized Residuals vs. fitted values to test homoscedasticity
plotResiduals(mdl,'probability')   % Normal probability plot to test normal distribution of error

%Calculate leverage. Use rule of thumb for high leverage>2(p+1)/n where p is the number of independent variables and n is the number of observations
h = leverage(X); 
p=1;
n=64;
thres=2*(p+1)/n;

cftool;  % Use cftool to get a graphical inspection of linear model and data. Use also cftool to calculate the confidence intervals of coefficients and other statistics

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    
    
