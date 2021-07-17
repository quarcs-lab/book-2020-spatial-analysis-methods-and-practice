* Clean environment
clear all
macro drop _all
cls
version 15


* Install packages
*ssc install spatreg
*ssc install spwmatrix
*ssc install sppack
*ssc install xsmle


* From Github, donwload a ZIP file containing the shape file
copy "https://github.com/quarcs-lab/data-open/raw/master/grekousis/CityGeoDa.zip" CityGeoDa.zip, replace
unzipfile CityGeoDa.zip

* TRANSLATE the general shapefile into a stata-format shapefile
spshape2dta CityGeoDa, replace

* Use and describe the translated shape file
use CityGeoDa, clear
describe
sum
spset

* SET new ID variable
*spset _ID, modify replace

* SET new coordinate units
*spset, modify coordsys(latlong, miles)
*save, replace


* OLS regression
regress Income Insurance
  * information criteria
  estat ic
  * evaluate residuals (pnorm should be along the line)
  predict r, resid
  kdensity r, kernel(gaussian ) normal
  pnorm r
  * Mulicollinerity test via VIF (VIF > 10 is  bad)
  vif
  * Heteroskedasticity test via  BP (p-vale <0.05 is bad)
  rvfplot, yline(0)
  estat hettest

* Create a map of the spatial distribution
*grmap, activate
*grmap Income, fcolor(Heat) clmethod(kmeans) clnumber(3) legenda(on) legorder(lohi) legstyle(2) legcount
*grmap Insurance, fcolor(Heat) clmethod(kmeans) clnumber(3) legenda(on) legorder(lohi) legstyle(2) legcount
*grmap r, fcolor(Heat) clmethod(kmeans) clnumber(5) legenda(on) legorder(lohi) legstyle(2) legcount


* Create contiguity matrix
*spmatrix create contiguity WqueenS, normalize(row) replace
*spmatrix summarize WqueenS

* Create  inverse distance matrix
*spmatrix create idistance WidistS, normalize(row) replace
*spmatrix summarize WidistS

* Import 8 nearest neighbours matrix
use "W8nn_withID.dta", clear
spset id
spmatrix fromdata W8nnS = m*, normalize(row) replace
spmatrix summarize W8nnS


*spmatrix dir

* Run the Moran test based on the residuals of an OLS regression
use CityGeoDa, clear
sort POLY_ID
gen id = POLY_ID
order id, first
spset id, modify replace

regress Income Insurance
estat moran, errorlag(W8nnS)
*estat moran, errorlag(WqueenS)
*estat moran, errorlag(WidistS)

* Run LM spatial diagnostics (needs spatreg package, which in turn needs a symmetric W matrix)
* [IMPORTANT] Import .dta weight matrix with spatwmat package, standardize it, and store eigen values
*spatwmat using "W8nn.dta", name(W8nnS_spatwmat) eigenval(eW8nnS_spatwmat) standardize
*spatwmat using "Wqueen.dta", name(WqueenS_spatwmat) eigenval(WqueenS_spatwmat) standardize
*use CityGeoDa, clear
*reg Income Insurance
*spatdiag, weights(WqueenS_spatwmat)

* Fit SLM(SAR) model: spatial lag of the dependent variable [AIC = 1628.111]
spregress Income Insurance, ml dvarlag(W8nnS) vce(robust)
  * Compute information criteria (only for maximum likelihood)
  estat ic
  * Compute spillover (indirect) effect
  estat impact

* Fit SEM model: spatial lag of the error (no spillover)  [AIC = 1604.61]
spregress Income Insurance, ml errorlag(W8nnS) vce(robust)
  * Compute information criteria (only for maximum likelihood)
  estat ic
  * Compute spillover (indirect) effect
  estat impact

* Fit SLX model: spatial lag of the independent variables [AIC = 1644.761]
spregress Income Insurance, ml ivarlag(W8nnS:Insurance) vce(robust)
  * Compute information criteria (only for maximum likelihood)
  estat ic
  * Compute spillover (indirect) effect
  estat impact

* Fit SDM model: spatial lag of the dependent and independent variables [AIC = 1604.229]
spregress Income Insurance, ml dvarlag(W8nnS) ivarlag(W8nnS:Insurance) vce(robust)
  * Compute information criteria (only for maximum likelihood)
  estat ic
  * Compute spillover (indirect) effect
  estat impact
