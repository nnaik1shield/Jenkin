SET SERVEROUTPUT ON SIZE 1000000
DECLARE
    CURSOR c_tabs IS
        SELECT table_name
          FROM tabs
         WHERE table_name NOT IN ('INSTALLATION','SYSTEM_ATTRIBUTE','SYSTEM_ATTRIBUTE_VALUE')
         ORDER BY table_name
        ;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );

BEGIN

    i := 0;
    FOR r_tabs IN c_tabs
    LOOP
        v_sql := 'TRUNCATE TABLE "' || r_tabs.table_name || '"';
    BEGIN
        EXECUTE IMMEDIATE v_sql;
        i := i + 1;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line( v_sql || ';' );
            dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
    END;
    END LOOP;
    dbms_output.put_line( i || ' tables truncated.' );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
