clear
set seed 111617

/*******************************************************************************
********************************************************************************

Step 1. Prepare AHRF files and Social Explorer files -> to be at the county level. 

********************************************************************************
********************************************************************************/

//Create Source Finder File of all Counties in US - Area Health Resouce File
import sas f00002 f04439 f04448 f04440 f04449 f00023 f13156 f0002013 f1255913 f12424 f00012 f1530711 f1530719 f1530811 f1530819 f1528911 f1528919 f1529219 f1529211 f1530911 f1530919 f1529319 f1529311 f1319319 f1319311 using "$ahrf\AHRF2021.sas7bdat", clear
	rename f00012 countyonly_fips
	rename f12424 state_abb
save "$ahrf\AHRF2021.dta", replace

import sas f00002 f04439 f04448 f04440 f04449 f00023 f13156 f0002013 f1255913 f12424 f00012 f1530711 f1530719 f1530811 f1530819 f1528911 f1528919 f1529219 f1529211 f1530911 f1530919 f1529319 f1529311 f1319319 f1319311 using "$ahrf\AHRF2019.sas7bdat", clear
	rename f00012 countyonly_fips
	rename f12424 state_abb
save "$ahrf\AHRF2019.dta", replace

use "$ahrf\AHRF2021.dta", clear
	merge 1:1 f00002 using "$ahrf\AHRF2019.dta"
	drop _merge
	rename f00002 county_fips 
	drop if state_abb == "GU" | state_abb == "PR" | state_abb == "VI" //Outside the scope of this analysis.
save "$ahrf\All_Counties.dta" , replace

//Prepare Social Explorer file 2011
import delimited "$socexp\R13094299_SL050_2011.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite11 = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack11 = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian11= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi11 = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother11 = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces11 = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	
	keep county_fips totalpopulationmorethan65years totalpopulation  medianhouseholdincomein2011infla populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite11 cnty_propblack11 cnty_propasian11 cnty_propaiannhopi11 cnty_propother11 cnty_propmultiplraces11 totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan65years pop65plus11
	rename totalpopulationmorethan85years pop85plus11
	rename totalpopulationmorethan75years pop75plus11
	rename totalpopulation totalpop11
	rename medianhouseholdincomein2011infla medianhhinc11
	rename populationage65andoverforwhompov pop65plus_povstatus11
	rename pop65inpov pop65plus_livinpov11
	rename pop65atorabovepov pop65plus_atabovepov11

	egen sum_pop65 = sum(pop65plus11)
	sum sum_pop65
		drop sum_pop65
	
save "$socexp\SocialExplorer2011.dta" , replace

//Prepare Social Explorer file 2015
import delimited "$socexp\R13094300_SL050_2015.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	keep county_fips totalpopulation totalpopulationmorethan65years
	
	rename totalpopulationmorethan65years pop65plus15
	rename totalpopulation totalpop15

save "$socexp\SocialExplorer2015.dta" , replace

//Prepare Social Explorer file 2019
import delimited "$socexp\R13094301_SL050_2019.csv", stringcols(1) clear	
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	gen cnty_propwhite19 = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack19 = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian19= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi19 = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother19 = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces19 = ( totalpopulationtwoormoreraces ) / totalpopulation * 100

	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincomein2019infla populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite19 cnty_propblack19 cnty_propasian19 cnty_propaiannhopi19 cnty_propother19 cnty_propmultiplraces19 totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan65years pop65plus19
	rename totalpopulationmorethan85years pop85plus19
	rename totalpopulationmorethan75years pop75plus19
	
	rename totalpopulation totalpop19
	rename medianhouseholdincomein2019infla medianhhinc19
	rename populationage65andoverforwhompov pop65plus_povstatus19
	rename pop65inpov pop65plus_livinpov19
	rename pop65atorabovepov pop65plus_atabovepov19
	
save "$socexp\SocialExplorer2019.dta" , replace

import delimited "$socexp\R13180833_SL050_2020.csv", stringcols(1) clear	
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	gen cnty_propwhite20 = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack20 = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian20= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi20 = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother20 = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces20 = ( totalpopulationtwoormoreraces ) / totalpopulation * 100

	rename v54 pop65inpov
	rename v55 pop65atorabovepov
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincomein2020infla populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite20 cnty_propblack20 cnty_propasian20 cnty_propaiannhopi20 cnty_propother20 cnty_propmultiplraces20 totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan65years pop65plus20
	rename totalpopulationmorethan85years pop85plus20
	rename totalpopulationmorethan75years pop75plus20
	
	rename totalpopulation totalpop20
	rename medianhouseholdincomein2020infla medianhhinc20
	rename populationage65andoverforwhompov pop65plus_povstatus20
	rename pop65inpov pop65plus_livinpov20
	rename pop65atorabovepov pop65plus_atabovepov20

save "$socexp\SocialExplorer2020.dta" , replace


//Merge AHRF, Social Explorer 2011, and Social Explorer 2019 data sets where AHRF is the finder file
use "$ahrf\All_Counties.dta" , clear
	merge 1:1 county_fips using "$socexp\SocialExplorer2011.dta"  
		keep if _merge == 1 | _merge == 3
		drop _merge
	merge 1:1 county_fips using "$socexp\SocialExplorer2015.dta"  
		keep if _merge == 1 | _merge == 3
		drop _merge
	merge 1:1 county_fips using "$socexp\SocialExplorer2019.dta"  
		keep if _merge == 1 | _merge == 3
		drop _merge
	merge 1:1 county_fips using "$socexp\SocialExplorer2020.dta"  
		keep if _merge == 1 | _merge == 3
		drop _merge
	
	label var cnty_propaiannhopi11 "2011 % Population American Indian, Alaskan Native, Native Hawaiian or Pacific Islander"
	label var cnty_propasian11 "2011 % Population Asian"
	label var cnty_propblack11 "2011 % Population Black or African American"
	label var cnty_propmultiplraces11 "2011 % Population Reporting Multiple Races"
	label var cnty_propother11 "2011 % Population not otherwise reported"
	label var cnty_propwhite11 "2011 % Population White"
	
	label var cnty_propaiannhopi19 "2019 % Population American Indian, Alaskan Native, Native Hawaiian or Pacific Islander"
	label var cnty_propasian19 "2019 % Population Asian"
	label var cnty_propblack19 "2019 % Population Black or African American"
	label var cnty_propmultiplraces19 "2019 % Population Reporting Multiple Races"
	label var cnty_propother19 "2019 % Population not otherwise reported"
	label var cnty_propwhite19 "2019 % Population White"
	
	label var cnty_propaiannhopi20 "2020 % Population American Indian, Alaskan Native, Native Hawaiian or Pacific Islander"
	label var cnty_propasian20 "2020 % Population Asian"
	label var cnty_propblack20 "2020 % Population Black or African American"
	label var cnty_propmultiplraces20 "2020 % Population Reporting Multiple Races"
	label var cnty_propother20 "2020 % Population not otherwise reported"
	label var cnty_propwhite20 "2020 % Population White"
	
save "$data\CountyYearDataSet_20112020.dta", replace

/*******************************************************************************
********************************************************************************

Step 2. Prepare  2011 Nursing Home Compare and LTCFocus Files - all at the county level.

********************************************************************************
********************************************************************************/
//Nursing Home Compare
import excel "$nhc\ratings2011.xlsx", sheet("Sheet1") firstrow case(lower) clear
	keep if month == 12
	destring overall_rating, replace
	gen starrating2011 = 1 if overall_rating == 10
		replace starrating2011 = 2 if overall_rating == 20 
		replace starrating2011 = 3 if overall_rating == 30 
		replace starrating2011 = 4 if overall_rating == 40 
		replace starrating2011 = 5 if overall_rating == 50 
		replace starrating2011 = 6 if overall_rating == 90 
		replace starrating2011 = 7 if overall_rating == 70
		
	label define str 1 "1 Star" 2 "2 Stars" 3 "3 Stars" 4 "4 Stars" 5 "5 Stars" 6 "Special Focus Facility" 7 "Too New to Rate" 
	label values starrating2011 str
	
	keep provnum starrating2011 state
		duplicates drop
	duplicates tag provnum state, gen (flag)
		tab flag
		drop flag
		
	label var provnum "Provider Number"
	label var state "State"
	label var starrating2011 "Facility Star Rating, 2011"
	
save "$nhc\StarRatings2011.dta", replace

//Prepare LTCFocus Facility Level Data to be merged
import excel "$ltcff\facility_2011.xls", sheet(Facility) firstrow case(lower) clear
	count
	*tab totbeds, m
	destring totbeds, replace
	egen total_number_beds = sum(totbeds)
	sum total_number_beds totbeds
	
	bysort state county: egen cnty_numberofbeds2011 = sum(totbeds)
	
	//number of for-profit beds
	gen forprofit = 1 if profit == "Yes"
		replace forprofit = 0 if profit == "No"
		
	gen facility_numprofitbeds = totbeds * forprofit
	bysort state county: egen cnty_numprofitbeds2011 = sum (facility_numprofitbeds)
	
	gen cnty_prop_profitbeds2011 = cnty_numprofitbeds2011 / cnty_numberofbeds2011 * 100
	
	//number of chain beds
	gen chain = 1 if multifac == "Yes"
		replace chain = 0 if multifac == "No"
		
	gen facility_chainbeds = totbeds * chain
	bysort state county: egen cnty_numchainbeds2011 = sum(facility_chainbeds)
	
	gen cnty_prop_chainbeds2011 = cnty_numchainbeds2011 / cnty_numberofbeds2011 * 100
	
	label var cnty_numberofbeds2011 "Number of total beds, County"
	label var cnty_numprofitbeds2011 "Number of For-profit Beds, County"
	label var cnty_prop_profitbeds2011 "Percent of County Beds are for-profit"
	label var cnty_prop_chainbeds2011 "Percent of County Beds are Chains"

	rename prov1680 provnum
	
	merge 1:1 provnum using "$nhc\StarRatings2011.dta"
		keep if _merge == 3
		drop _merge
	
	//number of beds per star rating
	gen fourfivestar = 0 //if starrating2019 < 7 <--This is not driving the findings in a major way - double checked.
		replace fourfivestar = 1  if starrating2011 == 4 | starrating2011 == 5
	
	gen fourfivestarbeds2011 = fourfivestar * totbeds
	
	bysort state county: egen cnty_numtopstarbeds2011 = sum(fourfivestarbeds2011)
	
	gen cnty_prop_45starbeds2011 = cnty_numtopstarbeds2011 / cnty_numberofbeds2011 * 100
	
	//percent of residents relying on Medicaid
	destring paymcaid, replace
	sum paymcaid
	
	bysort state county: egen cnty_paymcaid2011 = mean(paymcaid)
	
	keep county state cnty_numberofbeds cnty_numchainbeds cnty_numprofitbeds cnty_prop_chainbeds cnty_prop_profitbeds cnty_prop_45starbeds cnty_numtopstarbeds cnty_paymcaid2011
		duplicates drop
	
	rename county countyonly_fips
	rename state state_abb
	
	
save "$ltcff\CountyLevelBedDescriptives2011.dta", replace
	

/*******************************************************************************
********************************************************************************

Step 3. Prepare  2019 Nursing Home Compare and LTCFocus Files - all at the facility level. 

********************************************************************************
********************************************************************************/

import delimited "$nhc\ratings2019.csv", clear 
	destring overall_rating, replace
	gen starrating2019 = overall_rating
		replace starrating2019 = 6 if overall_rating_fn  == 18
		replace starrating2019 = 7 if overall_rating_fn  == 1
		
	label define str 1 "1 Star" 2 "2 Stars" 3 "3 Stars" 4 "4 Stars" 5 "5 Stars" 6 "Special Focus Facility" 7 "Too New to Rate" 
	label values starrating2019 str
	
	keep provnum starrating2019 state
	
	label var provnum "Provider Number"
	label var state "State"
	label var starrating2019 "Facility Star Rating, 2019"
	
save "$nhc\StarRatings2019.dta", replace


//Prepare LTCFocus Facility Level Data to be merged
import excel "$ltcff\facility_2019.xlsx", sheet(Facility) firstrow case(lower) clear
	
	*tab totbeds, m
	destring totbeds, replace
	bysort state county: egen cnty_numberofbeds2019 = sum(totbeds)
	
	//number of for-profit beds
	gen forprofit = 1 if profit == "Yes"
		replace forprofit = 0 if profit == "No"
		
	gen facility_numprofitbeds = totbeds * forprofit
	bysort state county: egen cnty_numprofitbeds2019 = sum (facility_numprofitbeds)
	
	gen cnty_prop_profitbeds2019 = cnty_numprofitbeds2019 / cnty_numberofbeds2019 * 100
	
	//number of chain beds
	gen chain = 1 if multifac == "Yes"
		replace chain = 0 if multifac == "No"
		
	gen facility_chainbeds = totbeds * chain
	bysort state county: egen cnty_numchainbeds2019 = sum(facility_chainbeds)
	
	gen cnty_prop_chainbeds2019 = cnty_numchainbeds2019 / cnty_numberofbeds2019 * 100
	
	label var cnty_numberofbeds2019 "Number of total beds, County"
	label var cnty_numprofitbeds2019 "Number of For-profit Beds, County"
	label var cnty_prop_profitbeds2019 "Percent of County Beds are for-profit"
	label var cnty_prop_chainbeds2019 "Percent of County Beds are Chains"

	rename prov1680 provnum
	
	merge 1:1 provnum using "$nhc\StarRatings2019.dta"
		keep if _merge == 3
		drop _merge
	
	//number of beds per star rating
	gen fourfivestar = 0  //if starrating2019 < 7 <--This is not driving the findings in a major way - double checked.
		replace fourfivestar = 1  if starrating2019 == 4 | starrating2019 == 5
	
	gen fourfivestarbeds2019 = fourfivestar * totbeds
	
	bysort state county: egen cnty_numtopstarbeds2019 = sum(fourfivestarbeds2019)
	
	gen cnty_prop_45starbeds2019 = cnty_numtopstarbeds2019 / cnty_numberofbeds2019 * 100
	
	//percent of residents relying on Medicaid
	destring paymcaid, replace
	sum paymcaid
	
	bysort state county: egen cnty_paymcaid2019 = mean(paymcaid)
	
	keep county state cnty_numberofbeds cnty_numchainbeds cnty_numprofitbeds cnty_prop_chainbeds cnty_prop_profitbeds cnty_prop_45starbeds cnty_numtopstarbeds cnty_paymcaid2019
		duplicates drop
	
	rename county countyonly_fips
	rename state state_abb
	
save "$ltcff\CountyLevelBedDescriptives2019.dta", replace
	

/*******************************************************************************
********************************************************************************

Step 4. Prepare  2020 Nursing Home Compare and LTCFocus Files - all at the facility level. 

********************************************************************************
********************************************************************************/

import delimited "$nhc\ratings2020.csv", clear 
	destring overallrating, replace
	gen starrating2020 = overallrating
		replace starrating2020 = 6 if specialfocusstatus == "SFF"
		replace starrating2020 = 7 if overallratingfootnote == 1
		
	label define str 1 "1 Star" 2 "2 Stars" 3 "3 Stars" 4 "4 Stars" 5 "5 Stars" 6 "Special Focus Facility" 7 "Too New to Rate" 
	label values starrating2020 str
	
	rename federalprovidernumber provnum
	rename providerstate state
	
	keep provnum starrating2020 state
	
	label var provnum "Provider Number"
	label var state "State"
	label var starrating2020 "Facility Star Rating, 2020"
	
save "$nhc\StarRatings2020.dta", replace


//Prepare LTCFocus Facility Level Data to be merged
import excel "$ltcff\facility_2020.xlsx", sheet(Facility) firstrow case(lower) clear
	
	*tab totbeds, m
	destring totbeds, replace
	bysort state county: egen cnty_numberofbeds2020 = sum(totbeds)
	
	//number of for-profit beds
	gen forprofit = 1 if profit == "Yes"
		replace forprofit = 0 if profit == "No"
		
	gen facility_numprofitbeds = totbeds * forprofit
	bysort state county: egen cnty_numprofitbeds2020 = sum (facility_numprofitbeds)
	
	gen cnty_prop_profitbeds2020 = cnty_numprofitbeds2020 / cnty_numberofbeds2020 * 100
	
	//number of chain beds
	gen chain = 1 if multifac == "Yes"
		replace chain = 0 if multifac == "No"
		
	gen facility_chainbeds = totbeds * chain
	bysort state county: egen cnty_numchainbeds2020 = sum(facility_chainbeds)
	
	gen cnty_prop_chainbeds2020 = cnty_numchainbeds2020 / cnty_numberofbeds2020 * 100
	
	label var cnty_numberofbeds2020 "Number of total beds, County"
	label var cnty_numprofitbeds2020 "Number of For-profit Beds, County"
	label var cnty_prop_profitbeds2020 "Percent of County Beds are for-profit"
	label var cnty_prop_chainbeds2020 "Percent of County Beds are Chains"

	rename prov1680 provnum
	
	merge 1:1 provnum using "$nhc\StarRatings2020.dta"
		keep if _merge == 3
		drop _merge
	
	//number of beds per star rating
	gen fourfivestar = 0  
		replace fourfivestar = 1  if starrating2020 == 4 | starrating2020 == 5
	
	gen fourfivestarbeds2020 = fourfivestar * totbeds
	
	bysort state county: egen cnty_numtopstarbeds2020 = sum(fourfivestarbeds2020)
	
	gen cnty_prop_45starbeds2020 = cnty_numtopstarbeds2020 / cnty_numberofbeds2020 * 100
	
	//percent of residents relying on Medicaid
	destring paymcaid, replace
	sum paymcaid
	
	bysort state county: egen cnty_paymcaid2020 = mean(paymcaid)
	
	keep county state cnty_numberofbeds cnty_numchainbeds cnty_numprofitbeds cnty_prop_chainbeds cnty_prop_profitbeds cnty_prop_45starbeds cnty_numtopstarbeds cnty_paymcaid2020
		duplicates drop
	
	rename county countyonly_fips
	rename state state_abb
	
save "$ltcff\CountyLevelBedDescriptives2020.dta", replace
	

//Create County-Year Level Files reflecting beds

use "$ltcff\CountyLevelBedDescriptives2011.dta", clear

	merge 1:1 state_abb countyonly_fips using "$ltcff\CountyLevelBedDescriptives2019.dta", keep(1 2 3)
	tab _merge
	drop _merge
	
	merge 1:1 state_abb countyonly_fips using "$ltcff\CountyLevelBedDescriptives2020.dta", keep(1 2 3)
	tab _merge
	drop _merge
save "$data\CountyLevelBedDescriptives_2020.dta", replace


/*******************************************************************************
********************************************************************************

Step 5. Merge County-Year Level files to Facility-Year Level files. 

********************************************************************************
********************************************************************************/

use "$data\CountyYearDataSet_20112020.dta", clear

	merge 1:1 state_abb countyonly_fips using "$data\CountyLevelBedDescriptives_2020.dta"
		keep if _merge == 1 | _merge == 3
		drop _merge
	
	gen neverhadNH_2019 = 0
		replace neverhadNH_2019 = 1 if cnty_numberofbeds2011 == . & cnty_numberofbeds2019 == . //230 changes
		
	gen neverhadNH_2020 = 0
		replace neverhadNH_2020 = 1 if cnty_numberofbeds2011 == . & cnty_numberofbeds2020 == . //230 changes
	
	//Create change in number of beds
	foreach var in cnty_numberofbeds2020 cnty_numberofbeds2019 cnty_numberofbeds2011 {
	replace `var' = 0 if `var' == . & neverhadNH_2019 == 0
	replace `var' = 0 if `var' == . & neverhadNH_2020 == 0
	}
	
	gen delta_cntybeds_2019 = cnty_numberofbeds2019 - cnty_numberofbeds2011 if neverhadNH_2019 == 0 
	gen delta_cntybeds_2020 = cnty_numberofbeds2020 - cnty_numberofbeds2011 if neverhadNH_2020 == 0 
	
	tab neverhadNH_2019 neverhadNH_2020 //Either variable can be used - perfect overlap
	
	//Create change in Number of Beds Adjusted for Population aged 65+
	gen cntybedsperpop2011 = cnty_numberofbeds2011 / pop65plus11 * 10000 if  neverhadNH_2019 == 0 
		replace cntybedsperpop2011 = 0 if cnty_numberofbeds2011 == . & neverhadNH_2019 == 0
	gen cntybedsperpop2019 = cnty_numberofbeds2019 / pop65plus19 * 10000 if  neverhadNH_2019 == 0 
		replace cntybedsperpop2019 = 0 if cnty_numberofbeds2019 == . & neverhadNH_2019 == 0
	gen cntybedsperpop2020 = cnty_numberofbeds2020 / pop65plus20 * 10000 if  neverhadNH_2019 == 0 
		replace cntybedsperpop2020 = 0 if cnty_numberofbeds2020 == . & neverhadNH_2019 == 0

	gen delta_cntybedsperpop_2019 = cntybedsperpop2019 - cntybedsperpop2011 if neverhadNH_2019 == 0
	gen delta_cntybedsperpop_2020 = cntybedsperpop2020 - cntybedsperpop2011 if neverhadNH_2020 == 0
	
	sum delta_cntybedsperpop_2019, d
	sum delta_cntybedsperpop_2019 if delta_cntybedsperpop_2019 < 0, d
	sum delta_cntybedsperpop_2019 if delta_cntybedsperpop_2019 > 0, d
	
	vioplot delta_cntybedsperpop_2019 , hor
	graph save "Graph" "$figure\Delta Adjusted Number of Beds_Violin Graph.gph", replace
	
	sum delta_cntybedsperpop_2020, d
	sum delta_cntybedsperpop_2020 if delta_cntybedsperpop_2020 < 0, d
	sum delta_cntybedsperpop_2020 if delta_cntybedsperpop_2020 > 0, d
	
	vioplot delta_cntybedsperpop_2020 , hor
	
	//Create Number of 4 or 5 star Beds Adjusted for population aged 65+
	foreach var in cnty_numtopstarbeds2020 cnty_numtopstarbeds2019 cnty_numtopstarbeds2011  {
	replace `var' = 0 if `var' == . & neverhadNH_2019 == 0
	}
	
	gen cntystarbedsperpop2011 = cnty_numtopstarbeds2011 / pop65plus11 * 10000  if neverhadNH_2019 == 0
	gen cntystarbedsperpop2019 = cnty_numtopstarbeds2019 / pop65plus19 * 10000 if neverhadNH_2019 == 0
	gen cntystarbedsperpop2020 = cnty_numtopstarbeds2020 / pop65plus20 * 10000 if neverhadNH_2019 == 0
	
	gen delta_cntystarbedsperpop_2019 = cntystarbedsperpop2019 - cntystarbedsperpop2011   if neverhadNH_2019 == 0
	gen delta_cntypropstarbeds_2019 = cnty_prop_45starbeds2019 - cnty_prop_45starbeds2011   if neverhadNH_2019 == 0

	gen delta_cntystarbedsperpop_2020 = cntystarbedsperpop2020 - cntystarbedsperpop2011   if neverhadNH_2019 == 0
	gen delta_cntypropstarbeds_2020 = cnty_prop_45starbeds2020 - cnty_prop_45starbeds2011   if neverhadNH_2019 == 0
		
	//Change in number of for-profit beds adjusted for population aged 65+
	foreach var in cnty_numprofitbeds2011 cnty_numprofitbeds2019 cnty_numprofitbeds2020 {
	replace `var' = 0 if `var' == . & neverhadNH_2019 == 0
	}
	
	gen cnty_numprofitbeds2011adj = cnty_numprofitbeds2011 / pop65plus11 * 10000 
	gen cnty_numprofitbeds2019adj = cnty_numprofitbeds2020 / pop65plus20 * 10000 
	gen cnty_numprofitbeds2020adj = cnty_numprofitbeds2020 / pop65plus20 * 10000 
	
	gen delta_adjforprofitbeds2019 = cnty_numprofitbeds2019adj - cnty_numprofitbeds2011adj  if neverhadNH_2019 == 0
	gen delta_propprofitbeds2019 = cnty_prop_profitbeds2019 - cnty_prop_profitbeds2011  if neverhadNH_2019 == 0
	
	gen delta_adjforprofitbeds2020 = cnty_numprofitbeds2020adj - cnty_numprofitbeds2011adj  if neverhadNH_2019 == 0
	gen delta_propprofitbeds2020 = cnty_prop_profitbeds2020 - cnty_prop_profitbeds2011  if neverhadNH_2019 == 0
	
	//Change in number of chain beds adjusted for population aged 65+
	foreach var in cnty_numchainbeds2011 cnty_numchainbeds2019 cnty_numchainbeds2020  {
	replace `var' = 0 if `var' == . & neverhadNH_2019 == 0
	}
	
	gen cnty_numchainbeds2011adj = cnty_numchainbeds2011 / pop65plus11 * 10000  if neverhadNH_2019 == 0
	gen cnty_numchainbeds2019adj = cnty_numchainbeds2019 / pop65plus20 * 10000  if neverhadNH_2019 == 0
	gen cnty_numchainbeds2020adj = cnty_numchainbeds2020 / pop65plus20 * 10000  if neverhadNH_2019 == 0
	
	gen delta_propchainbeds2019 = cnty_prop_chainbeds2019 - cnty_prop_chainbeds2011 if neverhadNH_2019 == 0
	gen delta_propchainbeds2020 = cnty_prop_chainbeds2020 - cnty_prop_chainbeds2011 if neverhadNH_2019 == 0
	
	//Change in percent of facility resdients relying on Medicaid
	foreach var in cnty_paymcaid2020 cnty_paymcaid2019 cnty_paymcaid2011  {
	replace `var' = 0 if `var' == . & neverhadNH_2019 == 0
	}
	
	gen delta_propmcaid2019 = cnty_paymcaid2019 - cnty_paymcaid2011 if neverhadNH_2019 == 0
	gen delta_propmcaid2020 = cnty_paymcaid2020 - cnty_paymcaid2011 if neverhadNH_2019 == 0
	
	//Type of County
	gen typeofcounty2019 = 0 if neverhadNH_2019 == 1
	replace typeofcounty2019 = 1 if delta_cntybedsperpop_2019 <= -10 & neverhadNH_2019 == 0
	replace typeofcounty2019 = 2 if delta_cntybedsperpop_2019 > -10 & delta_cntybedsperpop_2019 < 10
	replace typeofcounty2019 = 3 if delta_cntybedsperpop_2019 >= 10 & neverhadNH_2019 == 0 & delta_cntybedsperpop_2019 != .
	replace typeofcounty2019 = 4 if neverhadNH_2019 == 0 & delta_cntybedsperpop_2019 == .
	
	gen typeofcounty2020 = 0 if neverhadNH_2020 == 1
	replace typeofcounty2020 = 1 if delta_cntybedsperpop_2020 <= -10 & neverhadNH_2020 == 0
	replace typeofcounty2020 = 2 if delta_cntybedsperpop_2020 > -10 & delta_cntybedsperpop_2020 < 10
	replace typeofcounty2020 = 3 if delta_cntybedsperpop_2020 >= 10 & neverhadNH_2020 == 0 & delta_cntybedsperpop_2020 != .
	replace typeofcounty2020 = 4 if neverhadNH_2020 == 0 & delta_cntybedsperpop_2020 == .
	
	label define types 0 "Never Had Nursing Home" 1 "Decreasing Number of Beds" 2 "No Meaningful Change" 3 "Increasing Number of Beds" 4 "No population data"
	label values typeofcounty2019 types
	label values typeofcounty2020 types
	
	//Indicators of Rurality
	destring f0002013, replace
	gen rural = 0
		replace rural = 1 if f0002013 > 3 & f0002013 < .
	label define rrl 0 "Metropolitan" 1 "Non-metropolitan"
	label values rural rrl
	
	gen rucc_cat = 0 if f0002013 < 4 
		replace rucc_cat = 1 if f0002013 > 3 & f0002013 < 7
		replace rucc_cat = 2 if f0002013 > 6 & f0002013 < .
	label define rcc 0 "Metropolitan" 1 "Non-metropolitan/Metropolitan Adjacent" 2 "Non-metropolitan/Not metro adjacent"
	label values rucc_cat rcc
	
	//Demographic Variables
	gen percentpop65_2011 =  pop65plus11 / totalpop11 * 100
	gen percentpop65_2019 =  pop65plus19 / totalpop20 * 100
	gen percentpop65_2020 =  pop65plus20 / totalpop20 * 100
	
	gen percentpop65inpov_2011 =  pop65plus_livinpov11 / pop65plus_povstatus11 * 100
	gen percentpop65inpov_2019 =  pop65plus_livinpov19 / pop65plus_povstatus20 * 100
	gen percentpop65inpov_2020 =  pop65plus_livinpov20 / pop65plus_povstatus20 * 100
	
	//Final Labels for all Variables
	label var cnty_numtopstarbeds2011 "Number 4/5 Star Beds per County, 2011"
	label var cnty_numtopstarbeds2019 "Number 4/5 Star Beds per County, 2019"
	label var cnty_numtopstarbeds2020 "Number 4/5 Star Beds per County, 2020"
	label var cntystarbedsperpop2011 "Number 4/5 Star Beds per County per capita, 2011"
	label var cntystarbedsperpop2019 "Number 4/5 Star Beds per County per capita, 2019"
	label var cntystarbedsperpop2020 "Number 4/5 Star Beds per County per capita, 2020"
	label var delta_cntybedsperpop_2019 "Change in Beds per County per capita, 2011-2019"
	label var delta_cntybedsperpop_2020 "Change in Beds per County per capita, 2011-2020"
	label var delta_cntystarbedsperpop_2019 "Change in 4/5 Star Beds per County per capita, 2011-2019"
	label var delta_cntystarbedsperpop_2020 "Change in 4/5 Star Beds per County per capita, 2011-2020"
	label var rucc_cat "Rurality, 3 categories"
	label var cntybedsperpop2020 "Number of beds per County per capita, 2020"
	label var cntybedsperpop2019 "Number of beds per County per capita, 2019"
	label var cntybedsperpop2011 "Number of beds per County per capita, 2011" 
	label var cnty_prop_45starbeds2011 "Percent of Beds that are 4/5 Stars per County, 2011"
	label var cnty_prop_45starbeds2019 "Percent of Beds that are 4/5 Stars per County, 2019"
	label var cnty_prop_45starbeds2020 "Percent of Beds that are 4/5 Stars per County, 2020"
	label var typeofcounty2019 "Type of County, 2011-2019"
	label var typeofcounty2020 "Type of County, 2011-2020"
	label var rural "Rurality"
	label var cnty_numchainbeds2020 "Number Chain Beds per County, 2020"
	label var cnty_numchainbeds2019 "Number Chain Beds per County, 2019"
	label var cnty_numchainbeds2011	"Number Chain Beds per County, 2011"
	label var neverhadNH_2019 "Did not have SNF 2011 and 2020"
	label var percentpop65_2011 "Percent Population aged 65+, 2011"
	label var percentpop65_2019 "Percent Population aged 65+, 2019"
	label var percentpop65_2020 "Percent Population aged 65+, 2020"
	label var percentpop65inpov_2011 "Percent Population aged 65+ living in poverty, 2011"
	label var percentpop65inpov_2019 "Percent Population aged 65+ living in poverty, 2019"
	label var percentpop65inpov_2020 "Percent Population aged 65+ living in poverty, 2020"
	label var delta_cntybeds_2019 "Change in number of beds, 2011-2019"
	label var delta_cntybeds_2020 "Change in number of beds, 2011-2020"
	label var delta_propprofitbeds2019 "Change in proportion of for-profit beds, 2011-2019"
	label var delta_propprofitbeds2020 "Change in proportion of for-profit beds, 2011-2020"
	label var cnty_numprofitbeds2011adj "Number of For-Profit Beds per capita, 2011"
	label var cnty_numprofitbeds2019adj  "Number of For-Profit Beds per capita, 2019"
	label var cnty_numprofitbeds2020adj  "Number of For-Profit Beds per capita, 2020"
	label var delta_adjforprofitbeds2019 "Change in number of for-profit beds per capita, 2011-2019"
	label var delta_adjforprofitbeds2020 "Change in number of for-profit beds per capita, 2011-2020"
	label var cnty_numchainbeds2011adj "Number of Chain Beds per capita, 2011"
	label var cnty_numchainbeds2019adj "Number of Chain Beds per capita, 2019"
	label var cnty_numchainbeds2020adj "Number of Chain Beds per capita, 2020"
	label var cnty_paymcaid2020  "Average % of Facility Residents who primary payer is Medicaid, 2020"
	label var cnty_paymcaid2019  "Average % of Facility Residents who primary payer is Medicaid, 2019"
	label var cnty_paymcaid2011  "Average % of Facility Residents who primary payer is Medicaid, 2011"
	label var delta_propchainbeds2019 "Change in proportion of chain beds, 2011-2019"
	label var delta_propchainbeds2020 "Change in proportion of chain beds, 2011-2020"
	label var delta_propmcaid2019 "Change in average proportion of residents whose primary support is Medicaid, 2011-2019"
	label var delta_propmcaid2020 "Change in average proportion of residents whose primary support is Medicaid, 2011-2020"
	label var delta_cntypropstarbeds_2019 "Change in average proportion of 4/5 Star Beds, 2011-2019"
	label var delta_cntypropstarbeds_2020 "Change in average proportion of 4/5 Star Beds, 2011-2020"
	
save "$data\AnalyticDataset_with2020.dta", replace