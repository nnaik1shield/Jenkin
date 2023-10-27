SET SERVEROUTPUT ON SIZE 1000000
DECLARE
    CURSOR c_fk IS
        SELECT table_name tn, constraint_name cn
          FROM user_constraints
         WHERE constraint_type = 'R'
           AND status = 'ENABLED'
         ORDER BY table_name, constraint_name
        ;
    v_sql VARCHAR2( 200 );
    i NUMBER;
BEGIN

    i := 0;
    FOR r_fk IN c_fk
    LOOP
        v_sql := 'ALTER TABLE ' || r_fk.tn || ' DISABLE CONSTRAINT ' || r_fk.cn;
    BEGIN
        EXECUTE IMMEDIATE v_sql;
        i := i + 1;
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line( v_sql || ';' );
            dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
    END;
    END LOOP;
    dbms_output.put_line( i || ' constraints disabled.' );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
