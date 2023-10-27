SET SERVEROUTPUT ON SIZE 1000000
--
-- Drop Package Bodies and Type Bodies first, since they are dependent objects
--
DECLARE
    CURSOR c_object IS
        SELECT object_type type, object_name name
          FROM obj
         WHERE object_type = 'PACKAGE BODY'
            OR object_type = 'TYPE BODY'
         ORDER by object_type, object_name
        ;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );
    v_banner VARCHAR2( 200 );

BEGIN

    -- kludge to detect Oracle 10g
    SELECT banner
      INTO v_banner
      FROM v$version
     WHERE banner LIKE '%Oracle%';

    i := 1;
    WHILE i > 0
    LOOP
        SELECT COUNT(*)
          INTO i
          FROM obj
         WHERE object_type = 'PACKAGE BODY'
            OR object_type = 'TYPE BODY'
        ;

        dbms_output.put_line( TRIM( i || ' body objects left to drop.' ) );

        FOR ob IN c_object
        LOOP
            v_sql := 'DROP ' || ob.type || ' "' || ob.name ||'"';

            BEGIN
                EXECUTE IMMEDIATE v_sql;
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line( TRIM( v_sql || ';' ) );
                    dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
            END;
        END LOOP;

        -- kludge to purge 10g recyclebin
        IF v_banner LIKE '%10g%' THEN
            EXECUTE IMMEDIATE 'purge recyclebin';
            DBMS_OUTPUT.put_line('10g Recyclebin purged.');
        END IF;
    
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
--
-- Drop all objects other than INDEX and TYPE
--
DECLARE
    CURSOR c_object IS
        SELECT object_type type, object_name name
          FROM obj
         WHERE object_type <> 'INDEX'
           AND object_type <> 'INDEX PARTITION'
           AND object_type <> 'TABLE PARTITION'
           AND object_type <> 'LOB'
         ORDER by object_type, object_name
        ;
    i NUMBER := 1;
    v_sql VARCHAR2( 200 );
    v_banner VARCHAR2( 200 );

BEGIN

    -- kludge to detect Oracle 10g
    SELECT banner
      INTO v_banner
      FROM v$version
     WHERE banner LIKE '%Oracle%';

    i := 1;
    WHILE i > 0
    LOOP
        SELECT COUNT(*)
          INTO i
          FROM obj
        ;

        dbms_output.put_line( TRIM( i || ' objects left to drop.' ) );

        FOR ob IN c_object
        LOOP
            v_sql := 'DROP ' || ob.type || ' "' || ob.name || '"';

            IF ob.type = 'TABLE' THEN
                v_sql := v_sql || ' CASCADE CONSTRAINTS';
            END IF;
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
                        dbms_output.put_line( TRIM( v_sql || ';' ) );
                        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
                    END IF;
            END;
        END LOOP;

        -- kludge to purge 10g recyclebin
        IF v_banner LIKE '%10g%' THEN
            EXECUTE IMMEDIATE 'purge recyclebin';
            DBMS_OUTPUT.put_line('10g Recyclebin purged.');
        END IF;
    
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
