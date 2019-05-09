/*Read in csv file of homeless shelter data.*/
PROC IMPORT datafile= '/folders/myfolders/SASData/SMIS_Daily_Occupancy_2018.csv'
out=WORK.TorontoHomeless
DBMS=CSV
;
RUN;


/*Use sql code to create a table of only the January 2018 homeless data.*/
PROC SQL;
CREATE TABLE JanuaryHomeless AS
SELECT * 
FROM 
WORK.TORONTOHOMELESS
WHERE OCCUPANCY_DATE BETWEEN "01Jan2018"d and "31Jan2018"d;
;
QUIT;


/*Do one way Anova test comparing mean shelter occupancy in January 2018
of different sectors. This includes women, men, families, co-ed and youth.
Also do Tukey post hoc test to see if there are differences in means 
between each pair of groups.*/
ODS GRAPHICS ON;

TITLE "One way anova of Toronto homeless shelter occupancy in January 2018 by sector";
PROC GLM DATA=WORK.JANUARYHOMELESS PLOTS=DIAGNOSTICS(UNPACK);
	CLASS SECTOR;
	MODEL OCCUPANCY=SECTOR;
	MEANS SECTOR / HOVTEST;
	MEANS SECTOR / TUKEY;
RUN;
QUIT;

ODS GRAPHICS OFF;

/*Do t-test comparison between occupancy and capacity.
Need to set up a comparison factor for occupancy and capacity.*/
DATA WORK.JanuaryMod;
   SET WORK.januaryhomeless;
   Shelter_people_total_type = 'OCCUPANCY' ; Num_people= OCCUPANCY; OUTPUT;
   Shelter_people_total_type = 'CAPACITY'; Num_people = CAPACITY; OUTPUT;
   KEEP Shelter_people_total_type Num_people;
RUN;

/*Now we can do the t-test comparing shelter capacity with occupancy;
T-test histograms and Q-Q plots show that data is not normally 
distributed.  So t-test probably not the best choice for the data.*/
PROC TTEST data=WORK.JANUARYMOD;
  CLASS Shelter_people_total_type;
  VAR Num_people;
RUN;

/*Can also do a paired t-test if we assume that occupancy and capacity are
not independent from each other.  Reasonable assumption, but normality assumption
is still no good.*/
PROC TTEST DATA=WORK.JANUARYHOMELESS;
PAIRED OCCUPANCY*CAPACITY;
RUN;

/*Try doing a regression analysis between occupancy and capacity, to determine
if there is a relationship between these two variables for the shelters.  It turns
out that there is a very strong relationship between these variables*/
PROC REG DATA=WORK.JANUARYHOMELESS;
MODEL OCCUPANCY = CAPACITY;
RUN;

/*The data was not really normally distributed, so do a Mann-Whitney U test
instead of a T-test.*/
PROC NPAR1WAY DATA=WORK.JANUARYMOD;
CLASS Shelter_people_total_type;
VAR Num_people;
RUN;


