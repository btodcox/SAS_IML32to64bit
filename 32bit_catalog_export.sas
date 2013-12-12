libname libin "F:\ "; /* update with correct path to the 32-bit IML storage catalog */
libname libtemp "F:\   "; /*update with convenient temporary storage location */

%let storagename=IMLcatalogname;  /*update with correct name of 32-bit IML catalog to be "translated" */

proc catalog catalog=libin.&storagename; /*
	contents out=temp;
quit;

data temp1; 
	set temp (where = (TYPE='MATRIX'));  /*can on "translate" matrices; compiled modules ("imod") have to be recompiled for 64bit SAS */
run;


data _null_; /* create macrovariables for subsequent looping */
	set temp1;
	call symput (cats('matrix',_n_), name);
	call symput ("nobs", _n_); * keep overwriting value until end = total obs.;
run;



%macro write_datasets; /* write out each matrix in &storagename as a separate SAS dataset */
proc iml;
reset storage=libin.&storagename;
load;
/* macro variables for &nobs and all the “&&var&i” variables in previous data steps */
	%do i = 1 %to &nobs;
		create libtemp.&&matrix&i from &&matrix&i;
		append from &&matrix&i;
		close libtemp.&&matrix&i;
	%end; /* do i=1 %to &nobs; */
quit;
%mend write_datasets;

%write_datasets /*invoke the macro for the mega-dump of datasets */

