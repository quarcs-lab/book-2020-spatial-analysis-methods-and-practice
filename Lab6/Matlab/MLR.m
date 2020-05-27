%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grekousis G. 2020. Spatial Analysis Theory and Practice. Describe-Explore-Explain through GIS.
% Cambridge University Press. ISBN: 9781108614528. 
% https://www.cambridge.org/core/books/spatial-analysis-methods-and-practice/4C135005A621335D06CC63EFF17E3913#
%                    
%                Multiple Linear Regression 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Files stored in \BookLabs\Lab6\Matlab
% Data stored in Regression.xls (Worksheet:MLR)
% Matlab flles: MLR.m (this file), MLR.mat stores the dataset

load MLR   % Load data

% DATA stores the five Independent Variables: 
%	"Sec": percent of people obtained secondary education, 
%	"Unv": percent of people that graduated from university
%	"Med": medical expenses per month in Euros
%	"Ins": money spent for monthly insurance
%	"Ren": monthly rent in Euros

% Y stores the Dependent Variable (Income)
% myCell stores variables' names

% Multicollinearity test using the Belsley collinearity diagnostics
% Belsley, D. A., E. Kuh, and R. E. Welsh. Regression Diagnostics. New York, NY: John Wiley & Sons, Inc., 1980.
[sValue,condIdx,VarDecomp]=collintest(DATA); 

%Calculate pairwise correlations  
[R,Pvalue]=corrplot(DATA,'varNames',myCell);   
%R returns the correlation values displayed in the plots, Pvalue returns the p-values
%at 95% confidence interval

%Calculate the Variance Inflation Factor - VIF
VIF = diag(inv(R));

%MLR | Dependent is Income. 
TY=table(Y,'VariableNames',{'Income'});% Create a table instead of array to better handle data. Tables display variables' names. Using tables allows for variables' names incuded in the outputs
TX=array2table(DATA,'VariableNames',myCell); 

% First, delete Var Ins (Insurance expense) as it exhibits mulicollinearity with Med (MedicalExpenses)
TX.Ins=[];
%Add the dependent variable at the end to have one Table for the mdl function
tbl=[TX TY];
%Run MLR
mdl=fitlm(tbl); %returns a linear model fit to variables in the table or dataset array tbl. By default, fitlm takes the last variable as the response variable.
anova(mdl,'summary'); % ANOVA results summary
plot(mdl);% Plot observations, regression line, and confidence interval for mean Y(95%)

%Run the model by deleting Sec and Unv variables that have large p-values
tbl1=tbl;
tbl1.Sec=[];
tbl1.Unv=[];
mdl1=fitlm(tbl1);

%Calculate standardized coefficients (beta coefficients)
XY=table2array(tbl1); %Transform the table to array to calculate zscore
Z=zscore(XY);
tbl2=array2table(Z,'VariableNames',{'Med' 'Ren' 'Income'});
mdl2=fitlm(tbl2);  % The new coefficients produced are the standardized

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

