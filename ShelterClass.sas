/*Read in csv file of Toronto homeless shelter data.*/
PROC IMPORT datafile= '/folders/myfolders/SASData/SMIS_Daily_Occupancy_2018.csv'
out=WORK.TorontoHomeless
DBMS=CSV
;
RUN;

ODS GRAPHICS ON;
/*Make a Frequency table to determine which sectors are the most prevalent
for each available program.  Show a bar plot of the frequencies*/
PROC FREQ DATA=WORK.TORONTOHOMELESS ORDER=FREQ;
    TABLES SECTOR / PLOTS=all;
    TABLES SHELTER_NAME/ MAXLEVELS=10 PLOTS=all;
RUN;
ODS GRAPHICS OFF;


