# ADSL Dataset Validation
- Project Title: 	ADSL-Dataset-Validation
- Description: 		Validation of ADSL dataset by writing independent SAS code.
- SAS Version:		SAS onDemand for Academics
## Introduction 
The project involves validating an already developed ADSL (Analysis data subject level) dataset using the input datasets of ; 
- DM.SAS7bdat (Demographics SDTM dataset)
- EX.SAS7bdat (Exposure SDTM dataset)
- DS.SAS7bdat (Disposition SDTM dataset)
- VS.SAS7bdat (Vital signs SDTM dataset)

ADSL  is a domain in ADaM (Analysis Data Model) with a structure of one record per subject.

## Logical Follow.
- Establishing a library to house all four datasets. 
- Specifying variables from individual datasets according to the RSD (Requirement specification document). 
- Merging of the four datasets with USUBJID (unique subject ID)  and further specification of the other variable that requires variable from more than one dataset.
- After completion, the final dataset was sorted with the USUBJID (unique subject ID) 
- The final dataset was then compared with an already-developed ADSL.SAS7bdat.
## Inputs
    •DM.SAS7bdat
      •EX.SAS7bdat
        •DS.SAS7bdat
          •VS.SAS7bdat
            •ADSL.SAS7bdat


## Tasks
	As explained in the Requirement Specification (RSD) 🔽

|SN|Variable Name 	|Variable Label |Data Type|Length/Format 	|Algorithm|
|---|---------------|---------------|---------|---------------|---------|
|1|STUDYID|Study Identifier|Char|$20|DM.STUDYID|
|2|USUBJID |Unique Subject Identifier| Char|$20|DM.USUBJID|
|3|SUBJID  |Subject Identifier for the Study|Char|$20|DM.SUBJID|
|4|SITEID  |Study Site Identifier|Char|$20|DM.SITEID|
|5|AGE  |Age|Num|8|DM.AGE|
|6|AGEU  |Age Units|Char|$15|DM.AGE|
|7|SEX  |Sex|Char|$1|DM.SEX|
|8|SEXN |Sex (N) |Num |8 |SEXN=1 when SEX='M'; else 2 when SEX='F'|
|9|RACE |Race |Char |$50 |DM.RACE |
|10|COUNTRY |Country |Char |$8 |DM.COUNTRY |
|11|REGION| REGION| Char| $20 | if country in('CAN','USA') then region='NORTH AMERICA' else if country in ('AUT','BEL','DNK','ITA','NLD','NOR','SWE','FRA','ISR') then region='WESTERN EUROPE' else if country in ('BLR','BGR','HUN','POL','ROU','RUS','SVK','UKR','TUR') then region='EASTERN EUROPE'; else if country in ('AUS','CHN','HKG','IND','MYS','SGP','TWN','THA') then region='ASIA';  else if country in ('ARG','CHL','COL','MEX','PER') then region='LATIN AMERICA';|
|12|ARM |Description of Planned Arm |Char |$50| DM.ARM |
|13|ARMCD |Planned Arm Code |Char| $20 |DM.ARMCD|
|14|ACTARM| Description of Actual Arm| Char |$50 |EX.EXTRT |
|15|ACTARMCD| Actual Arm Code |Char| $20| ACTARMCD='PLAC' When EX.EXTRT='Placebo';  else' CYT00110' when EX.EXTRT='CYT001 10 MG '; else 'CYT0013 ' when EX.EXTRT='CYT001 3 MG ';|
|16|TRT01P |Planned Treatment for Period 01  |Char |$50| DM.ARM|
|17|TRT01PN |Planned Treatment for Period 01 (N) |Num |8|TRT01PN=1 when DM.ARM='Placebo '; else 2 when	DM.ARM='CYT001 3 MG'; else 3 when	DM.ARM='CYT001 10 MG';|
|18|TRT01A |Actual Treatment for Period 01 |Char |$50| EX.EXTRT |
|19|TRT01AN |Actual Treatment for Period 01 (N)| Num| 8|TRT01AN=1 when DM.ARM='Placebo '; else 2 when DM.ARM='CYT001 10 MG'; else 3 when DM.ARM='CYT001 3 MG' |
|20|ARFSTDT |Analysis Ref Start Date |Num| Date9.|Converting DM.RFSTDTC from character ISO8601 format to numeric date9 format. |
|21|ARFENDT| Analysis Ref End Date| Num |Date9.|When DM.RFENDTC is not missing then DM.RFENDTC; else DS.DSSTDTC when DS.DSSCAT='END OF STUDY '|
|22|TRTSDT| Date of First Exposure to Treatment |Num |Date9.|Min(EXSTDTC) or For each subject select the EX record with the First. EXSTDTC. Convert EX.EXSTDTC SAS date9 format|
|23|TRTEDT |Date of Last Exposure to Treatment |Num |Date9.|Max(EXENDTC) or For each subject select the EX record with the Last. EXENDTC. Convert EX.EXENDTC SAS date9 format.| 
|24|TRT01SDT |Date of First Exposure in Period 01| Num |Date9.| Assign TRTSDT|
|25|TRT01EDT |Date of Last Exposure in Period 01 |Num |Date9.| Assign TRTEDT|
|26|AP01SDT |Period 01 start date |Num |Date9.| AP01SDT= min(sv.svstdtc) |
|27|AP01EDT |Period 01 end date| Num| Date9.| AP01SDT=TRT01EDT+28 days |
|28|RANDDT |Date of Randomization |Num |Date9. |Convert DSSTDTC to SAS date9 when DS.DSDECOD is 'RANDOMIZED' and DSSCAT is 'RANDOMIZATION'; else missing; |
|29|SAFFL |Safety Population Flag |char| $1| set to 'Y' when RANDDT is not missing and EX.EXSTDTC is not missing |
|30|RANDFL |Randomized Population Flag |Char |$1| set to 'Y' when RANDDT is not missing;|
|31|DTHFL| Subject Death Flag |Char| $1|DTHFL='Y ' when DS.DSDECOD="DEATH " and DSCAT="DISPOSITION EVENT "|
|32|DTHDT |Date of Death |Num| Date9.|DTHDT =DS. DSSTDTC when DS.DSDECOD="DEATH " and DSCAT="DISPOSITION EVENT "; else missing; Convert to SAS date9 format|
|33|STYDURD |Total Study Duration (Days) |Num |8 |Derived as ARFENDT-ARFSTDT+1 |
|34|EOSFL| End of Study Flag |Char| $1 |Set to 'Y' When DS.DSSCAT = 'END OF STUDY'; else 'N' |
|35|EOSDT |End of Study Date| Num |Date9.|Convert DS.DSSTDTC to SAS date9 format when DS.DSSCAT = 'END OF STUDY' and DSDECOD="DISPOSITION EVENT "; |
|36|EOS |Reason for ending study| Char| $50 |If dscat eq ‘DISPOSITION EVENT’ and dsdecod=”COMPLETED” then eos=’COMPLETED” Else if dscat eq ‘DISPOSITION EVENT’ then eos=dsterm|
|37|EOSCODE| Reason For Ending study Code |Char| $50|If dscat eq ‘DISPOSITION EVENT’ and dsdecod=”COMPLETED” then eoscode=’COMPLETED” Else if dscat eq ‘DISPOSITION EVENT’ then eoscode=DSDECOD|
|38|WGTB |Weight at BL (kg) |Num |8 |set to VS.VSSTRESN when VS.VSTESTCD=Weight and VSBLFL=Y|
|39|HGTB |Height at BL (cm) |Num| 8 |Set to VS.VSSTRESN when VS. VSTESTCD=Height and VSBLFL=Y|	
|40|BMI| BMI at BL (kg/m^2) |Num| 8 |BMI=(WEIGHT*703)/(HEIGHT**2) |


## Output
- [Dataset](https://github.com/princeadeyemoboy/ADaM-Dataset-Validation-ADSL-/blob/main/qc_adsl.sas7bdat)
- [Program](https://github.com/princeadeyemoboy/ADaM-Dataset-Validation-ADSL-/blob/main/QC_adsl.sas)
- [Log](https://github.com/princeadeyemoboy/ADaM-Dataset-Validation-ADSL-/blob/main/QC_adsl.log)
- [Listing](https://github.com/princeadeyemoboy/ADaM-Dataset-Validation-ADSL-/blob/main/QC_adsl.lst)
- [Initial](https://github.com/princeadeyemoboy/ADaM-Dataset-Validation-ADSL-/blob/main/initial.sas)

