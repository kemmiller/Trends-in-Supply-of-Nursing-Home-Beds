/*******************************************************************************
********************************************************************************

Step 1. Prepare AHRF files and Social Explorer files -> to be at the county level. 

********************************************************************************
********************************************************************************/

//Create Source Finder File of all Counties in US - Area Health Resouce File
import sas f00002 f04439 f04448 f04440 f04449 f0002013 f12424 ///
using "$ahrf\AHRF2021.sas7bdat", clear
	rename f12424 state_abb
	
	gen year2011 = 0
	gen year2012 = 0
	gen year2013 = 0
	gen year2014 = 0
	gen year2015 = 0
	gen year2016 = 0
	gen year2017 = 0
	gen year2018 = 0
	gen year2019 = 0
	gen year2020 = 0
	
	drop if state_abb == "GU" | state_abb == "PR" | state_abb == "VI" //Outside the scope of this analysis.
	
	reshape long year , i(f00002) j(time)
	drop year
	rename time year
	rename f00002 county_fips
save "$ahrf\County Finder File R&R.dta", replace

//Prepare Social Explorer file 2011
import delimited "$socexp\R13094299_SL050_2011.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2011infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2011
	
save "$socexp\SocialExplorer2011.dta" , replace


//Prepare Social Explorer file 2012
import delimited "$socexp\R13267913_SL050_2012.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2012infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2012
	
save "$socexp\SocialExplorer2012.dta" , replace

//Prepare Social Explorer file 2013
import delimited "$socexp\R13267914_SL050_2013.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2013infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2013
	
save "$socexp\SocialExplorer2013.dta" , replace


//Prepare Social Explorer file 2014
import delimited "$socexp\R13267915_SL050_2014.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2014infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2014
	
save "$socexp\SocialExplorer2014.dta" , replace

//Prepare Social Explorer file 2015
import delimited "$socexp\R13094300_SL050_2015.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2015infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2015

save "$socexp\SocialExplorer2015.dta" , replace

//Prepare Social Explorer file 2016
import delimited "$socexp\R13267916_SL050_2016.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2016infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2016
	
save "$socexp\SocialExplorer2016.dta" , replace

//Prepare Social Explorer file 2017
import delimited "$socexp\R13267917_SL050_2017.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2017infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2017
	
save "$socexp\SocialExplorer2017.dta" , replace

//Prepare Social Explorer file 2018
import delimited "$socexp\R13267918_SL050_2018.csv",  stringcols(1) clear
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100
	
	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2018infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov

	egen sum_pop65 = sum(pop65plus)
	sum sum_pop65
		drop sum_pop65
	
	gen year = 2018
	
save "$socexp\SocialExplorer2018.dta" , replace

//Prepare Social Explorer file 2019
import delimited "$socexp\R13094301_SL050_2019.csv", stringcols(1) clear	
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100

	rename v98 pop65inpov
	rename v99 pop65atorabovepov
	rename medianhouseholdincomein2019infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov
	
	gen year = 2019
	
save "$socexp\SocialExplorer2019.dta" , replace

import delimited "$socexp\R13180833_SL050_2020.csv", stringcols(1) clear	
	destring fips, replace
	gen str5 county_fips = string(fips, "%05.0f") //Create variable of state and county fips as a string variable to be merged
	gen cnty_propwhite = totalpopulationwhitealone  / totalpopulation * 100
	gen cnty_propblack = totalpopulationblackorafricaname / totalpopulation * 100
	gen cnty_propasian= totalpopulationasianalone / totalpopulation * 100
	gen cnty_propaiannhopi = ( totalpopulationamericanindianand + totalpopulationnativehawaiianand ) / totalpopulation * 100
	gen cnty_propother = ( totalpopulationsomeotherracealon ) / totalpopulation * 100
	gen cnty_propmultiplraces = ( totalpopulationtwoormoreraces ) / totalpopulation * 100

	rename v54 pop65inpov
	rename v55 pop65atorabovepov
	rename medianhouseholdincomein2020infla medianhouseholdincome
	
	keep county_fips totalpopulationmorethan65years totalpopulation medianhouseholdincome populationage65andoverforwhompov pop65inpov pop65atorabovepov cnty_propwhite cnty_propblack cnty_propasian cnty_propaiannhopi cnty_propother cnty_propmultiplraces totalpopulationmorethan75years totalpopulationmorethan85years

	rename totalpopulationmorethan75years pop75plus
	rename totalpopulationmorethan85years pop85plus
	
	rename totalpopulationmorethan65years pop65plus
	rename totalpopulation totalpop
	rename medianhouseholdincome medianhhinc
	rename populationage65andoverforwhompov pop65plus_povstatus
	rename pop65inpov pop65plus_livinpov
	rename pop65atorabovepov pop65plus_atabovepov
	
	gen year = 2020

save "$socexp\SocialExplorer2020.dta" , replace

//Merge AHRF and Social Explorer data sets where AHRF is the finder file
	
use "$socexp\SocialExplorer2011.dta" , clear
	append using "$socexp\SocialExplorer2012.dta" ///
	 "$socexp\SocialExplorer2013.dta" ///
	 "$socexp\SocialExplorer2014.dta" ///
	 "$socexp\SocialExplorer2015.dta" ///
	 "$socexp\SocialExplorer2016.dta" ///
	 "$socexp\SocialExplorer2017.dta" ///
	 "$socexp\SocialExplorer2018.dta" ///
	 "$socexp\SocialExplorer2019.dta" ///
	 "$socexp\SocialExplorer2020.dta" 
save "$socexp\SocialExplorerAllyears.dta" , replace

/*******************************************************************************
********************************************************************************

Step 2. Prepare  2011 Nursing Home Compare and LTCFocus Files - all at the county level.

********************************************************************************
********************************************************************************/

//Prepare LTCFocus Facility Level Data to be merged

forvalues i = 2011(1)2016 {
import excel "C:\Users\kemm\Box\Project Files\Rural Nursing Home Closures\Data\Data for Manuscript\LTCFocus 2022 Data Pull\County\county_`i'.xls",  firstrow case(lower) clear
	statastates, a(state)
	gen str2 state_fips_string = string(state_fips, "%02.0f")
	egen county_fips = concat(state_fips_string county)
	keep county_fips year state totbeds_cty
	destring totbeds_cty , replace
save "$ltcff\LTCFocusCounty`i'.dta" , replace
}

forvalues i = 2017(1)2018 {
import delimited "C:\Users\kemm\Box\Project Files\Rural Nursing Home Closures\Data\Data for Manuscript\LTCFocus 2022 Data Pull\County\county_`i'.csv",  clear
	statastates, a(state)
	gen str3 countyfips = string(county, "%03.0f")
	gen str2 state_fips_string = string(state_fips, "%02.0f")
	egen county_fips = concat(state_fips_string countyfips)
	keep county_fips year state totbeds_cty
	destring totbeds_cty, replace
save "$ltcff\LTCFocusCounty`i'.dta" , replace
}

forvalues i = 2019(1)2020 {
import excel "C:\Users\kemm\Box\Project Files\Rural Nursing Home Closures\Data\Data for Manuscript\LTCFocus 2022 Data Pull\County\county_`i'.xls",  firstrow case(lower) clear
	statastates, a(state)
	gen str2 state_fips_string = string(state_fips, "%02.0f")
	egen county_fips = concat(state_fips_string county)
	keep county_fips year state totbeds_cty
	destring totbeds_cty, replace
save "$ltcff\LTCFocusCounty`i'.dta" , replace
}

use "$ltcff\LTCFocusCounty2011.dta" , clear
	append using "$ltcff\LTCFocusCounty2012.dta" ///
	"$ltcff\LTCFocusCounty2013.dta" ///
	"$ltcff\LTCFocusCounty2014.dta" ///
	"$ltcff\LTCFocusCounty2015.dta" ///
	"$ltcff\LTCFocusCounty2016.dta" ///
	"$ltcff\LTCFocusCounty2017.dta" ///
	"$ltcff\LTCFocusCounty2018.dta" ///
	"$ltcff\LTCFocusCounty2019.dta" ///
	"$ltcff\LTCFocusCounty2020.dta" 
	duplicates drop
save "$ltcff\LTCFocusCountyAllYears.dta" , replace


use "$ahrf\County Finder File R&R.dta" , clear
	merge 1:1 county_fips year using "$socexp\SocialExplorerAllyears.dta"
		keep if  _merge == 3
		drop _merge
	merge 1:1 county_fips year using "$ltcff\LTCFocusCountyAllYears.dta"
		keep if _merge == 1 | _merge == 3
	*replace totbeds_cty = 0 if totbeds_cty == .
	drop _merge
	
	keep county_fips year pop65plus totbeds_cty state*
	
	gen adjustednumberofbeds = totbeds_cty / pop65plus * 10000
	
	bysort year : egen totalnumbeds = sum(totbeds_cty)
	bysort year : egen totalpop65 = sum(pop65plus)
	bysort year : egen totaladjnumbeds = sum(adjustednumberofbeds)
	
	tab year, sum(totalnumbeds)
	tab year, sum(totalpop65)
	
	twoway (line totalnumbeds year if year < 2020, sort), ylabel(1600000(20000)1700000) xlabel(2011(1)2019) ytitle(Total Number of Nursing Home Beds) xtitle(Year) legend(off) scheme(white_brbg)
	graph save "Graph" "$figure\Total Number of Beds.gph" , replace
	graph export "$figure\Total Number of Beds.png", as(png) name("Graph") replace
	
	twoway (line totalpop65 year if year < 2020, sort), ylabel(39600000(1000000)52400000) xlabel(2011(1)2019) ytitle(Total Number of Adults Aged 65 or older) xtitle(Year) legend(off) scheme(white_brbg)
	graph save "Graph" "$figure\Total Number of Adults 65 older.gph" , replace
	graph export "$figure\Total Number of Adults 65 older.png", as(png) name("Graph") replace
	
	twoway (line totaladjnumbeds year if year < 2020, sort), xlabel(2011(1)2019) ytitle("Total Number of Nursing Home Beds per 10,000 Adults Aged 65+") xtitle(Year) legend(off) scheme(white_brbg)
	graph save "Graph" "$figure\Total Adjusted Number of Beds.gph" , replace
	graph export "$figure\Total Adjusted Number of Beds.png", as(png) name("Graph") replace
	
save "$data\Figure 2 CountyYearDataSet_20112020 R&R.dta", replace
