The following analysis looks at the state of homeless shelters in the
city of Toronto.  The shelter data was taken from the City of Toronto
website and is publicly available.  SAS was used to compare occupancy
vs capacity of the shelters for the month of January 2018.  The ANOVA
test compared occupancy of each shelter by sector type (men, women,
families, co-ed and youth).  As expected, families contributed to the
highest mean occupancy, since a family contains multiple people.  The test
should that there were differences in mean occupancy among different sectors.
However the test also showed that the data was not normally distributed, so
this test shouldn't really be used to see if there is a difference between
mean shelter occupancy and mean capacity.  The t-test was also done to see
if there was a mean difference between occupancy and capacity overall, but
again, the Q-Q plot in this test should that the these variables were not 
normally distributed, so this test also shouldn't be used.  Instead, a non-
parametric test was used to compare occupancy and capacity.  This test showed
that overall, mean capacity was higher than mean occupancy for January 2018 
(to a 0.05 signficance level), but there were exceptions.  The regression plot showed
a very strong relationship between shelter occupancy and capacity, as one would
expect.  But it also showed occupancy in excess of capacity for some shelters on
some days that month, which is a challenge for both the staff at the shelter and
the people staying there.     