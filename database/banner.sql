--
-- banner.sql - show banner based on current and update version strings
--
DISCONNECT
CONNECT &&ST_USER/&&ST_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE 1000000
SET FEEDBACK OFF
--
DECLARE
    v_core_version VARCHAR2(100) := '&&CORE_VERSION';
    v_client_version VARCHAR2(100) := '&&CLIENT_VERSION';
    v_md_version installation.md_version%type;
    v_st_version installation.st_version%type;
    v_api_version installation.api_version%type;
BEGIN
    --
    -- Show current installed version
    --
    SELECT core_version,    md_version,    st_version,    api_version
      INTO v_core_version,  v_md_version,  v_st_version,  v_api_version
      FROM installation;

    dbms_output.put_line( '.');
    dbms_output.put_line( '. Current installed versions are:');
    dbms_output.put_line( '.');
    dbms_output.put_line( '. CORE version:  ' || v_core_version );
    dbms_output.put_line( '. MD version:    ' || v_md_version );
    dbms_output.put_line( '. ST version:    ' || v_st_version );
    dbms_output.put_line( '. API version:   ' || v_api_version );
    dbms_output.put_line( '.');

    --
    -- Show what version we plan to update to
    --
    --
    -- core bundle
    --
    IF (LENGTH(v_core_version) IS NOT NULL)
    AND (LENGTH(v_client_version) IS NULL)
    THEN
        dbms_output.put_line( '.');
        dbms_output.put_line( '. This bundle will update Dragon to::');
        dbms_output.put_line( '.');
        dbms_output.put_line( '. Core version:   '||v_core_version);
        dbms_output.put_line( '.');
    --
    -- client bundle
    --
    ELSIF (LENGTH(v_core_version) IS NULL)
    AND (LENGTH(v_client_version) IS NOT NULL)
    THEN
        dbms_output.put_line( '.');
        dbms_output.put_line( '. This bundle will update Dragon to::');
        dbms_output.put_line( '.');
        dbms_output.put_line( '. Client version: '||v_client_version);
        dbms_output.put_line( '.');
    --
    -- core and client bundle
    --
    ELSIF (LENGTH(v_core_version) IS NOT NULL)
    AND (LENGTH(v_client_version) IS NOT NULL)
    THEN
        dbms_output.put_line( '.');
        dbms_output.put_line( '. This bundle will update Dragon to::');
        dbms_output.put_line( '.');
        dbms_output.put_line( '. Core version:   '||v_core_version);
        dbms_output.put_line( '. Client version: '||v_client_version);
        dbms_output.put_line( '.');
    --
    -- uh-oh, we don't know what we are doing.
    -- Fire a warning shot...
    --
    ELSE
        dbms_output.put_line( '!!!'||CHR(7)||CHR(7)||CHR(7));
        dbms_output.put_line( '!!! ERROR! THIS BUNDLE HAS NO VERSION STRINGS DEFINED!');
        dbms_output.put_line( '!!! YOU MUST ABORT AT ONCE (CTRL+C) AND CONTACT ONESHIELD!');
        dbms_output.put_line( '!!!');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
.
/
SET FEEDBACK ON
--
-- eof
--
DISCONNECT
