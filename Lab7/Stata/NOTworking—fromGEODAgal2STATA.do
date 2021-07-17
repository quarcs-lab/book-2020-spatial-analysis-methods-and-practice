clear all
macro drop _all

* Install spwmatrix package to import gdal files
*ssc install spwmatrix
* ssc install sppack
* ssc install xsmle


* Import .gal file and export it as .txt matrix
spwmatrix import using "WqueenGeoda.gal", wname(WqueenGeoda) xport(WqueenGeoda, txt) replace


* Load .txt matrix
insheet using "WqueenGeoda.txt", delimiter(" ")  clear


* Remove first row and last column, which only indicates the number of spatial units
drop if _n == 1

rename v# m#, renumber


* Generate IDs for spatial units
gen id = _n
order id, first


* Check: Usually the IDs are wrong! They are in the opposite order
** Let's correct the IDs
gsort -id
drop id

gen id = _n
order id, first



* Save  matrix
save "WqueenGeodaWithID.dta", replace
export delimited "WqueenGeodaWithID.txt", novarnames replace

drop id
save "WqueenGeoda.dta", replace
export delimited "WqueenGeoda.txt", novarnames replace
