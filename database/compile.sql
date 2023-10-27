SET SERVEROUTPUT ON SIZE 1000000
--
-- display initial count of invalid objects
--
SET feedback OFF
DECLARE
    v_date DATE;
    v_count NUMBER;
BEGIN
        SELECT SYSDATE
          INTO v_date
          FROM dual;
        dbms_output.put_line( 'Compile starting at '||TO_CHAR(v_date,'YYYY-MM-DD HH24:MI:SS'));

         SELECT COUNT(1)
           INTO v_count
           FROM user_objects
          WHERE object_type IN ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','TYPE','VIEW')
            AND status = 'INVALID';
        dbms_output.put_line( v_count || ' invalid objects initially.');

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/

--
-- attempt to compile invalid objects
--
DECLARE
    v_sql VARCHAR2(255);
    CURSOR c_source IS
        SELECT object_type type, object_name name
          FROM user_objects
         WHERE object_type IN ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','TYPE','VIEW')
           AND status = 'INVALID'
        ;
    v_bad NUMBER;
BEGIN
        v_bad := 0;

        FOR r_source IN c_source
        LOOP
            IF r_source.type = 'PACKAGE BODY' THEN
                v_sql := 'ALTER PACKAGE ' || r_source.name || ' COMPILE BODY';
            ELSE
                v_sql := 'ALTER '|| r_source.type || ' ' || r_source.name || ' COMPILE';
            END IF;

            BEGIN
--                dbms_output.put_line( v_sql);
                EXECUTE IMMEDIATE v_sql;
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line( v_sql || ';' || CHR(10) || CHR(9) || TRIM( SQLERRM( SQLCODE ) ) );
                    v_bad := v_bad + 1;
            END;
        END LOOP;

        dbms_output.put_line( v_bad || ' objects with errors during compile.' );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/

--
-- display final count of invalid objects
--
DECLARE
    v_date DATE;
    v_count NUMBER;
BEGIN
         SELECT COUNT(1)
           INTO v_count
           FROM user_objects
          WHERE object_type IN ('FUNCTION','PACKAGE','PACKAGE BODY','PROCEDURE','TYPE','VIEW')
            AND status = 'INVALID';

        dbms_output.put_line( v_count || ' invalid objects remaining.');

        SELECT SYSDATE
          INTO v_date
          FROM dual;
        dbms_output.put_line( 'Compile complete at '||TO_CHAR(v_date,'YYYY-MM-DD HH24:MI:SS'));

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
SET feedback ON
