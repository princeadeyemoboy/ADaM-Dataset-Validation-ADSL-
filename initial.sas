
/*--------------------------------------------------------------------------------------
STUDY					: 
PROGRAM					: initial.sas 
SAS VERSION				: University Edition
DESCRIPTION				: This program is to setup libnames/filenames. 
AUTHOR					: Olamide Adeyemo
DATE COMPLETED			: 20/June/2023
PROGRAM INPUT			: Rand.sas7bdat,DS.sas7bdat,Comvar.sas7bdat
PROGRAM OUTPUT			: DS.sas,DS.sas7bdat
PROGRAM LOG				: &workpath\09out_logs\demo01.log
EXTERNAL MACROS CALLED	: None
EXTERNAL CODE CALLED	: initial.sas

LIMITATIONS				: None

PROGRAM ALGORITHM:
	Step 01: Setup macro variables, drive, project and protocol.            
   	Step 02: Define filename/libname for protocol.  
	Step 03: Define global options.
	Step 04: Include format files. 

REVISIONS: 					
	1. DD/MM/YYYY - Name (First Last) - Description of revision 1
	2. DD/MM/YYYY - Name (First Last) - Description of revision 2
----------------------------------------------------------------------------------------*/

*----------------------------------------------------------------*;
*- Step 01: Setup macro variables, drive, project and protocol. -*;
*----------------------------------------------------------------*;

%let cydrive      =/home/;                 					*- Drive name  -*;			            
                                                              
%let project      = u63305369/ADaM Dataset Validation (ADSL);  *- Project name -*;	

%let workpath     = &cydrive/&project/Work;  			


%let validatedir     = &workpath/08Validate;
%let logdir      = &workpath/05out_log;
%let program    = &workpath/06program;

*------------------------------------------------------------*;
*- Step 02: Global macro library filenames and libnames. 	-*;
*- Please update filename statements as per your need		-*;
*- Please add libname statements here						-*;
*------------------------------------------------------------*;	
filename  ffile1 "&workpath/";	
filename  ffile2 "&workpath/";

libname rawdata "&workpath/02data_raw";					*- Libname name for raw datasets -*;	
libname anadata "&workpath/07Output";			*- Libname name for analysis datasets -*;
libname original "&workpath/03data_analysis";
*----------------------------*;
*- Step 03: Global options. -*;
*----------------------------*;
options VALIDVARNAME=UPCASE spool compress=yes;						

*--------------------------------------------------------------------------------*;
*- Step 04: Include format files. 											 	-*;
*- Please comment the following include statement if you don't have format file.-*;
*--------------------------------------------------------------------------------*;
/*%inc "&workpath\08pgm_analysis\formats.sas";*/

