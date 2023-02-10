/*
Created by: Katherine Miller
Last Updated: 01/03/2022

The purpose of this file is to create descriptive statistics for supply of nursing home beds adjusted per population and to describe the counties experiencing growth versus contraction in number of beds adjusted per population.

We use the following data sources:

	1. Area Health Resource File (2019 release). https://data.hrsa.gov/topics/health-workforce/ahrf 
		-Source file for all counties in the US

	2. Long-term Care Focus County-Level Files (years 2011-2019). https://ltcfocus.org/ 
		-County-level variables describing nursing facilities beds, resident characteristics, and subset of quality measures.
		
	3. Social Explorer Data Downloads (CSV Files for years 2011-2019). https://www.socialexplorer.com/reports/socialexplorer/en/surveys
		-County-level variables describing the demographic and economic characteristics of counties.
		
The .do file is structured as follows.
	Step 1. Create Analytic Data set
	Step 2. Create Tables for manuscript
	Step 3. Create maps/figures for manuscript
	Step 4. Examine Alternative Threshold
*/

clear
set seed 111617

//Install packages
ssc install table1
ssc install maptile
ssc install spmap
maptile_install using "http://files.michaelstepner.com/geo_county2010.zip"
maptile_install using "http://files.michaelstepner.com/geo_state.zip"
ssc install vioplot

//Set global statements to call/save data
global data "\Data\Data for Manuscript\Analytic Files"
global ltcff "\Data\Data for Manuscript\LTCFocus 2022 Data Pull\Facility"
global ltcfc "\Data for Manuscript\LTCFocus 2022 Data Pull\County"
global ahrf "\Data\Data for Manuscript\AHRF"
global socexp "\Data\Data for Manuscript\Social Explorer"
global nhc "\Data\Data for Manuscript\Nursing Home Compare"
global socexp "\Data\Data for Manuscript\Social Explorer"
global do "\Programs\R&R Descriptive Paper of SNF Supply"

//Set global statements to save output
global log "\Output\Log Files"
global table "\Output\Tables"
global figure "\Output\Figures"


// Construct data set
	do "$do\1. Create Analytic Dataset.do"

// Produce Tables for Manuscript
	do "$do\2. Create Tables.do"

// Produce Figures for Manuscript
	do "$do\3. Create Figures.do"

//Examine Alternative Threshold
	do "$do\4. Examine alternative thresholds.do"