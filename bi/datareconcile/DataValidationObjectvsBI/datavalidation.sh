#This Script send alerts in case there any batch failure or batch not executed at all

#!/bin/bash
#set -x
. ~/.bash_profile
export ORAENV_ASK=NO
export ORACLE_SID=RMANDB
. oraenv
export ORAENV_ASK=YES
#Inputs $1 is environment name $2 is the tnsentry $3 email addresses
ENV=$1
DB=$2

#Email
EMAIL_LIST=$3
EMAIL_FROM="DoNotReply_"$ENV"@oneshield.com"

#Database
UNAME="DATARECONCILE"
UPWD="DATAREC0NCILED"

#Path
FilePath="/home/oracle/scripts/"${ENV,,}"DataValidation/"
#OraclePath=$FilePath"instantclient/"
TempPath=$FilePath"tmp/"
export LD_LIBRARY_PATH=$OraclePath
ScriptLoc="$FilePath/sqlfiles"
sqlplus -s $UNAME/${UPWD}@$DB <<EOF 
show user;
@$ScriptLoc/create_data_recon_tables.sql;
@$ScriptLoc/insert_dr_data_reconcile_metadata.sql;
@$ScriptLoc/vw_dr_data_reconcile_history.sql;
@$ScriptLoc/create_dr_data_reconcile_object_table.sql;
@$ScriptLoc/data_validation_process.sql;
@$ScriptLoc/insert_dr_data_reconcile_history.sql;
@$ScriptLoc/generate_insert_dr_data_reconcile_history.sql;

exit;
EOF

#Files
FILE_DATE=$(date +%m%d%Y)
SummaryFile=$TempPath$ENV"_summary_"$FILE_DATE".txt"
HtmlFile=$TempPath$ENV"_stat_"$FILE_DATE".html"

# echo " Cron File Path: "$FilePath
# echo " Oracle File Path: "$OraclePath
# echo " Temp Patch: "$TempPath
# echo " Database User Name: "$UNAME
# echo " Database: "$DB
# echo " Environment: "$ENV
# echo " Summary File: "$SummaryFile
# echo " Temp File: "$HtmlFile
# echo " Email List: "$EMAIL_LIST
# echo " Email From: "$EMAIL_FROM

#delete temporary files older than 10 days
find $TempPath -mindepth 1 -mtime +10 -delete

#Change directory to Oracle client
cd $OraclePath

# -----------DATA VALIDATION-----------
echo "<h3>Data Validation Summary</h3>" > $HtmlFile
echo "<br/><h4>Environment: "$ENV"</h4>" >> $HtmlFile
echo "<h4>Report Time: "$(date +'%B %d, %Y, %l:%M %p %Z')"</h4>" >> $HtmlFile

echo "<br/><h3>Object Comparison results between BI Table vs Object Tables</h3>" >> $HtmlFile

sqlplus -S -M  "HTML ON" $UNAME/${UPWD}@$DB <<EOF | /usr/bin/tee -a > $SummaryFile
set termout off
set markup HTML ON HEAD "<style type='text/css'> body {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} p {font:10pt Arial,Helvetica,sans-serif; color:black; background:White;} table,tr,td {font:10pt Arial,Helvetica,sans-serif; color:Black; background:white; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px; white-space:nowrap;} th {font:bold 10pt Arial,Helvetica,sans-serif; color:#336699; background:white; padding:0px 0px 0px 0px;} h1 {font:16pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; border-bottom:1px solid #cccc99; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;} h2 {font:bold 10pt Arial,Helvetica,Geneva,sans-serif; color:#336699; background-color:White; margin-top:4pt; margin-bottom:0pt;} a {font:9pt Arial,Helvetica,sans-serif; color:#663300; background:#ffffff; margin-top:0pt; margin-bottom:0pt; vertical-align:top;}</style><title>Data Validation Report</title>" BODY "" TABLE "border='1' align='center' width='100%' summary='Script output'" SPOOL ON ENTMAP ON PREFORMAT  OFF
set pages 1000
set trimspool on

prompt

select * from
	vw_dr_data_reconcile_history
where
	"As of Date" = trunc(sysdate);

prompt
exit
EOF

# in case the query returns no record, replace the feedback with a keyword
sed -i "s/no rows selected/NO_RECON_DATA_FOUND/g" $SummaryFile
echo `cat $SummaryFile` >> $HtmlFile

# if there is any data returned for any of the section in the file then send an email else do not do anything.
if [[ `grep -c "NO_RECON_DATA_FOUND" $HtmlFile` -eq 0 || `grep -c "NO_HISTORIC_RECON_DATA_FOUND" $HtmlFile` -eq 0 ]]
then

	(
	 echo "MIME-Version: 1.0"
	 echo "Content-Type: text/html"
	 echo "Content-Disposition: inline"
	 cat $HtmlFile
	) | mutt -s "[DataReconcile][BIvsObject] [$ENV]" $EMAIL_LIST -e "set content_type=text/html; my_hdr From:$EMAIL_FROM" < $HtmlFile 

fi

#End of script
