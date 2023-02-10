use "$data\AnalyticDataset_with2020.dta", clear

	gen pcntchange2019 = delta_cntybedsperpop_2019 / cntybedsperpop2011 * 100 if neverhadNH_2019 == 0
	
	gen threshold = 0
	replace threshold = 1 if pcntchange > 2.5 & pcntchange < .
	replace threshold = 1 if pcntchange < 2.5 & pcntchange < .

	drop typeofcounty2019
	
	//Type of County
	gen typeofcounty2019 = 0 if neverhadNH_2019 == 1
	replace typeofcounty2019 = 1 if threshold == 1 & pcntchange < 0 & neverhadNH_2019 == 0
	replace typeofcounty2019 = 2 if threshold == 0 & neverhadNH_2019 == 0
	replace typeofcounty2019 = 3 if threshold == 1 & pcntchange > 0 & neverhadNH_2019 == 0
	replace typeofcounty2019 = 4 if neverhadNH_2019 == 0 & delta_cntybedsperpop_2019 == .
	
	label define types 0 "Never Had Nursing Home" 1 "Decreasing Number of Beds" 2 "No Meaningful Change" 3 "Increasing Number of Beds" 4 "No population data" , replace 
	label values typeofcounty2019 types
	
	foreach var in delta_propprofitbeds2019 delta_propchainbeds2019 delta_cntypropstarbeds_2019 delta_propmcaid2019 {
		sum `var' if typeofcounty2019 == 2
	}
	
	tab typeofcounty2019, sum(cntybedsperpop2011)
	tab typeofcounty2019, sum(delta_cntybedsperpop_2019)
	
	tab typeofcounty2019, sum(cnty_prop_profitbeds2011)
	tab typeofcounty2019, sum(delta_propprofitbeds2019)
	
	tab typeofcounty2019, sum(cnty_prop_chainbeds2011)
	tab typeofcounty2019, sum(delta_propchainbeds2019)
		
	tab typeofcounty2019, sum(cnty_prop_45starbeds2011)
	tab typeofcounty2019, sum(delta_cntypropstarbeds_2019)
	
	tab typeofcounty2019, sum(cnty_paymcaid2011)
	tab typeofcounty2019, sum(delta_propmcaid2019)
	
	table1 if typeofcounty2019 > 0 & typeofcounty2019 < 4, vars ( ///
	cntybedsperpop2011 contn \ ///
	delta_cntybedsperpop_2019 contn \ ///
	cnty_prop_profitbeds2011 contn \ ///
	delta_propprofitbeds2019 contn \ ///
	cnty_prop_chainbeds2011 contn \ ///
	delta_propchainbeds2019 contn \ ///
	cnty_prop_45starbeds2011 contn \ ///
	delta_cntypropstarbeds_2019 contn \ ///
	cnty_paymcaid2011  contn \ ///
	delta_propmcaid2019  contn \ ///
	cntybedsperpop2011 conts \ ///
	delta_cntybedsperpop_2019 conts \ ///
	cnty_prop_profitbeds2011 conts \ ///
	delta_propprofitbeds2019 conts \ ///
	cnty_prop_chainbeds2011 conts \ ///
	delta_propchainbeds2019 conts \ ///
	cnty_prop_45starbeds2011 conts \ ///
	delta_cntypropstarbeds_2019 conts \ ///
	cnty_paymcaid2011  conts \ ///
	delta_propmcaid2019  conts \ ///
	) by(typeofcounty2019) onecol percent format(%13.1fc) cformat(%13.1fc) saving ("$table\Appendix B Table 1 R&R.xls", replace)