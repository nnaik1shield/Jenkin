DISCONNECT
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
SET SERVEROUTPUT ON SIZE UNLIMITED
SET FEEDBACK OFF
--
-- update installed versions
--
DECLARE
    v_os_user installation.os_user%TYPE;
    v_host installation.host%TYPE;
    v_ip_address installation.ip_address%TYPE;
    v_message installation.message%TYPE;
    v_core_version VARCHAR2(30) := '&&CORE_VERSION';
    v_client_version VARCHAR2(30) := '&&CLIENT_VERSION';
    v_md_version installation.md_version%type;
    v_st_version installation.st_version%type;
    v_api_version installation.api_version%type;
	v_core_claim_version installation.core_claim_version%type;
	v_core_billing_version  installation.core_billing_version%type;
    b_column_exists NUMBER := 0;
    b_version VARCHAR2(30) := '&&CLIENT_VERSION';
    sql_stmt VARCHAR(200);
BEGIN
    --
    -- get user information
    --
    SELECT
    	sys_context('USERENV','OS_USER'),
    	sys_context('USERENV','HOST'),
    	sys_context('USERENV','IP_ADDRESS')
    INTO
        v_os_user,
        v_host,
        v_ip_address
    FROM
        dual;
    
    --
    -- update installation table
    --
    IF (LENGTH(v_core_version) IS NOT NULL)
    AND (LENGTH(v_client_version) IS NULL)
    THEN
        v_message := 'Update to '||v_core_version||' completed on '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||' by '||v_os_user ||' from '|| v_host ||' - '|| v_ip_address;
        UPDATE
        	installation
        SET
        	os_user = v_os_user,
        	host = v_host,
                ip_address = v_ip_address,
                update_date = SYSDATE,
                message = v_message,
                core_version = v_core_version;
        --
        -- commit information
        --
        COMMIT;

    ELSIF (LENGTH(v_client_version) IS NOT NULL)
    AND (LENGTH(v_core_version) IS NULL)
    THEN
        v_message := 'Update to '||v_client_version||' completed on '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||' by '||v_os_user ||' from '|| v_host ||' - '|| v_ip_address;
        UPDATE
        	installation
        SET
        	os_user = v_os_user,
        	host = v_host,
                ip_address = v_ip_address,
                update_date = SYSDATE,
                message = v_message,
                md_version = v_client_version,
                st_version = v_client_version,
                api_version = v_client_version,
				core_claim_version = v_client_version,
				core_billing_version = v_client_version;
        --
        -- commit information
        --
        COMMIT;

    ELSIF (LENGTH(v_client_version) IS NOT NULL)
    AND (LENGTH(v_core_version) IS NOT NULL)
    THEN
        v_message := 'Update to '||v_core_version||' and '||v_client_version||' completed on '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||' by '||v_os_user ||' from '|| v_host ||' - '|| v_ip_address;
        UPDATE
        	installation
        SET
        	os_user = v_os_user,
        	host = v_host,
                ip_address = v_ip_address,
                update_date = SYSDATE,
                message = v_message,
                core_version = v_core_version,
                md_version = v_client_version,
                st_version = v_client_version,
                api_version = v_client_version;
        --
        -- commit information
        --
        COMMIT;

    END IF;

    SELECT count(*) INTO b_column_exists
    FROM user_tab_cols
    WHERE column_name = 'BASE_VERSION'
    AND table_name = 'INSTALLATION';
    
    IF (b_column_exists = 1) THEN
        sql_stmt := 'UPDATE INSTALLATION SET BASE_VERSION = :1';
        EXECUTE IMMEDIATE sql_stmt USING b_version;
    END IF;
    COMMIT;
    --
    -- print information message to screen
    --
    dbms_output.put_line( v_message);
    
    --
    -- Show final installed versions
    --
    SELECT core_version,    md_version,    st_version,    api_version, core_claim_version, core_billing_version
      INTO v_core_version,  v_md_version,  v_st_version,  v_api_version, v_core_claim_version, v_core_billing_version
      FROM installation;

    dbms_output.put_line( '.');
    dbms_output.put_line( '. Final installed versions are:');
    dbms_output.put_line( '.');
    dbms_output.put_line( '. CORE version:  ' || v_core_version );
    dbms_output.put_line( '. MD version:    ' || v_md_version );
    dbms_output.put_line( '. ST version:    ' || v_st_version );
    dbms_output.put_line( '. API version:   ' || v_api_version );
	dbms_output.put_line( '. CLAIM version:   ' || v_core_claim_version );
	dbms_output.put_line( '. BILLING version:' || v_core_billing_version ); 
    dbms_output.put_line( '.');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
--
SET FEEDBACK ON
--
-- eof
--
DISCONNECT
