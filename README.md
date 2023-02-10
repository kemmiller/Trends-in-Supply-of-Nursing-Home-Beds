# Trends-in-Supply-of-Nursing-Home-Beds

**Overview**

Before running the code:

  1. Copy file contents into personal folder

  2. Change the file path of the data and output global statements at the beginning of each .do file to the location of the project folder  

Once these changes have been made, running the file labeled “1. Create Analytic Dataset.do” will construct the analytic data set; running the file labeled “2. Create Tables.do” will produce the tables corresponding to the manuscript; running the file labeled “3. Figures” will create the figures for the manuscript; and, running the file labeled "4. Examine alternative thresholds" creates the tables for the sensitivity analysis examining alternative thresholds of meaningful change in supply of nursing home beds.

For questions about the code, please contact Katherine Miller (Katherine.miller@pennmedicine.upenn.edu).

**Data required:**
1. LTCFocus: https://ltcfocus.org/data
2. Nursing Home Compare: https://data.cms.gov/provider-data/topics/nursing-homes
3. Area Health Resource File: https://data.hrsa.gov/topics/health-workforce/ahrf
4. American Community Survey 5-year Estimates from Social Explorer: https://www.socialexplorer.com/
5. NIC-MAP. NIC-MAP data permissions will be required and data is stored in the HSRDC.

**Running the code:**

This code is for Stata, and has been verified to run in version 17. The following packages are required:

  1. Table1
  2. Maptile
  3. Spmap
  4. Vioplot
