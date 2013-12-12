
libname libout "D:\Documents\Preferences Study\SAS Analysis\Round 2\SAS_Lib_least";


%let storagename=IMLcatalog; /* change to be the name you want for the catalog */

data _null_; /* create macrovariables for subsequent looping */
	set libout.temp1;
	call symput (cats('matrix',_n_), name);
	call symput ("nobs", _n_);   /* keep overwriting value until end = total number of matrices */
run;


%macro create_iml_catalog;

proc iml;
/* macro variables for &nobs and all the “&&var&i” variables in previous data steps */
	%do i = 1 %to &nobs;
		use libout.&&matrix&i;
		read all var _NUM_ into &&matrix&i;
		close libout.&&matrix&i;
	%end; /* do i=1 %to &nobs; */
reset storage=libout.&storagename;
store;
quit;
%mend create_iml_catalog;


%create_iml_catalog /*invoke the macro for the mega-dump of datasets */


