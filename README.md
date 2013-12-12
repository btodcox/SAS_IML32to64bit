SAS (as of 9.3) cannot transfer IML matrices storted in 32-bit catalogs to 64-bit storage catalogs.  
CPORT and CIMPORT through error messages and digging through SAS document confirms this inability.

If you have IML catalogs with dozens or hundreds of matrices, it may be feasible to re-run
your analysis on 64-bit SAS for a number of reasons (lack of source code, run time, etc.).

The files in this repo allow you to quickly and easily save matrices (not imod or compiled code) to SAS datasets on
with 32-bit SAS and then import the matrices back into an IML storage catalogs on 64-bit SAS.