--
-- _droptypes.sql - recursively drop Oracle TYPE BODY and TYPE objects
--
SET SERVEROUTPUT ON SIZE 1000000
--
-- Drop Type Bodies first, since they are dependent objects
--
DECLARE
    CURSOR c_object IS
        SELECT object_type type, object_name name
          FROM obj
         WHERE object_type = 'TYPE BODY'
         ORDER by object_type, object_name
        ;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );

BEGIN

    i := 1;
    WHILE i > 0
    LOOP
        SELECT COUNT(*)
          INTO i
          FROM obj
         WHERE object_type = 'TYPE BODY'
        ;

        dbms_output.put_line( i || ' TYPE BODY objects left to drop.');

        FOR ob IN c_object
        LOOP
            v_sql := 'DROP ' || ob.type || ' ' || ob.name;

            BEGIN
                EXECUTE IMMEDIATE v_sql;
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line( v_sql || ';' );
                    dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
            END;
        END LOOP;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
--
-- Drop Collection TYPE objects next
--
DECLARE
    CURSOR c_type IS
        SELECT type_name
          FROM user_coll_types
         ORDER by 1;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );

BEGIN

    i := 1;
    WHILE i > 0
    LOOP
        SELECT COUNT(*)
          INTO i
          FROM user_coll_types;

        dbms_output.put_line( i || ' Collection TYPE objects left to drop.');

        FOR r_type IN c_type
        LOOP
            v_sql := 'DROP TYPE '|| r_type.type_name;

            BEGIN
                EXECUTE IMMEDIATE v_sql;
            EXCEPTION
                WHEN OTHERS THEN
                    --
                    -- do not echo messages for missing type dependents
                    --
                    IF SQLCODE = -2303 THEN
                        NULL;
                    ELSE
                        dbms_output.put_line( v_sql || ';' );
                        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
                    END IF;
            END;
        END LOOP;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
--
-- Drop TYPE objects last
--
DECLARE
    CURSOR c_type IS
        SELECT type_name
          FROM user_types
         ORDER by 1;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );

BEGIN

    i := 1;
    WHILE i > 0
    LOOP
        SELECT COUNT(*)
          INTO i
          FROM user_types;

        dbms_output.put_line( i || ' Object TYPE objects left to drop.');

        FOR r_type IN c_type
        LOOP
            v_sql := 'DROP TYPE '|| r_type.type_name;

            BEGIN
                EXECUTE IMMEDIATE v_sql;
            EXCEPTION
                WHEN OTHERS THEN
                    --
                    -- do not echo messages for missing type dependents
                    --
                    IF SQLCODE = -2303 THEN
                        NULL;
                    ELSE
                        dbms_output.put_line( v_sql || ';' );
                        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
                    END IF;
            END;
        END LOOP;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
