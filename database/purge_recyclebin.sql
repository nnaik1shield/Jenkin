--
-- purge_recyclebin.sql
-- purge the Oracle 10g Recycle Bin - no-op for Oracle 9i
--
SET SERVEROUTPUT ON SIZE UNLIMITED
DECLARE
    v_banner VARCHAR2(64);

BEGIN

    -- kludge to detect Oracle 10g
    SELECT banner
      INTO v_banner
      FROM v$version
     WHERE banner LIKE '%Oracle%';

    -- kludge to purge 10g recyclebin
    IF v_banner LIKE '%10g%' THEN
        EXECUTE IMMEDIATE 'purge recyclebin';
        DBMS_OUTPUT.put_line('10g Recyclebin purged.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
