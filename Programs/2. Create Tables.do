use "$data\AnalyticDataset_with2020.dta", clear

	foreach var in percentpop65_2011 percentpop65inpov_2011 medianhhinc11 f1529211 f1529311 f1319311 {
		sktest `var' if typeofcounty2019 >  0 & typeofcounty2019 < 4
		histogram  `var' if typeofcounty2019 > 0 & typeofcounty2019 < 4, normal
	}

	table1 if typeofcounty2019 > 0 & typeofcounty2019 < 4, vars( ///
	percentpop65_2011 contn \ ///
	percentpop65inpov_2011 contn \ ///
	medianhhinc11 contn \ ///
	f1529211 contn \ ///
	f1529311 contn \ ///
	f1319311 contn \ ///
	percentpop65_2011 conts \ ///
	percentpop65inpov_2011 conts \ ///
	medianhhinc11 conts \ ///
	f1529211 conts \ ///
	f1529311 conts \ ///
	f1319311 conts \ ///
	rural bin \ ///
	rucc_cat cat  \ ///
	f04448 cat  ///
	) by(typeofcounty2019) test onecol  format(%13.1fc) cformat(%13.1fc) saving ("$table\Table 1 R&R.xls", replace)
	
	table1 if typeofcounty2019 > 0 & typeofcounty2019 < 4, vars( ///
	percentpop65_2011 contn \ ///
	percentpop65inpov_2011 contn \ ///
	medianhhinc11 contn \ ///
	f1529211 contn \ ///
	f1529311 contn \ ///
	f1319311 contn \ ///
	percentpop65_2011 conts \ ///
	percentpop65inpov_2011 conts \ ///
	medianhhinc11 conts \ ///
	f1529211 conts \ ///
	f1529311 conts \ ///
	f1319311 conts \ ///
	rural bin \ ///
	rucc_cat cat  \ ///
	f04448 cat  ///
	) onecol  format(%13.1fc) cformat(%13.1fc) saving ("$table\Table 1 All Counties with NH R&R.xls", replace)
	
	table1 if typeofcounty2019 == 0, vars( ///
	percentpop65_2011 contn \ ///
	percentpop65inpov_2011 contn \ ///
	medianhhinc11 contn \ ///
	f1529211 contn \ ///
	f1529311 contn \ ///
	f1319311 contn \ ///
	percentpop65_2011 conts \ ///
	percentpop65inpov_2011 conts \ ///
	medianhhinc11 conts \ ///
	f1529211 conts \ ///
	f1529311 conts \ ///
	f1319311 conts \ ///
	rural bin \ ///
	rucc_cat cat  \ ///
	f04448 cat  ///
	) onecol  format(%13.1fc) cformat(%13.1fc) saving ("$table\Table 1 Counties with no NH R&R.xls", replace)
		