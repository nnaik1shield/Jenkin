CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
SET SERVEROUTPUT ON
DECLARE
	cnt INT;
BEGIN
	select count (*) into cnt from installation i where i.CORE_VERSION = '&&PREDECESSOR_RELEASE' or i.MD_VERSION = '&&PREDECESSOR_RELEASE';
if cnt = 0
then
	select count (*) into cnt from installation_log il where il.CORE_VERSION = '&&PREDECESSOR_RELEASE' or il.MD_VERSION = '&&PREDECESSOR_RELEASE';
	if cnt = 0
	then
		dbms_output.put_line( '------------------------------------------------' );
		dbms_output.put_line( 'THE PREDECESSOR RELEASE HAS NOT BEEN DEPLOYED YET' );
		dbms_output.put_line( 'CTRL-C to exit' );
	else
		dbms_output.put_line( '------------------------------------------------' );
		dbms_output.put_line( 'THE PREDECESSOR RELEASE HAS BEEN DEPLOYED' );
		dbms_output.put_line( 'Hit ENTER to continue' );
	end if;
else
	dbms_output.put_line( '------------------------------------------------' );
	dbms_output.put_line( 'THE PREDECESSOR RELEASE HAS BEEN DEPLOYED' );
	dbms_output.put_line( 'Hit ENTER to continue' );
end if;
end;
/