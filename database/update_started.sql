SET SERVEROUTPUT ON SIZE UNLIMITED
CONNECT &&API_USER/&&API_PASS@&&DB_NAME
--
-- print / update installation information
--
DECLARE
    v_os_user installation.os_user%TYPE;
    v_host installation.host%TYPE;
    v_ip_address installation.ip_address%TYPE;
    v_message installation.message%TYPE;
    v_core_version VARCHAR2(30) := '&&CORE_VERSION';
    v_client_version VARCHAR2(30) := '&&CLIENT_VERSION';
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
        v_message := 'Update to '||v_core_version||' started on '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||' by '||v_os_user ||' from '|| v_host ||' - '|| v_ip_address;
        UPDATE
        	installation
        SET
        	os_user = v_os_user,
        	host = v_host,
                ip_address = v_ip_address,
                update_date = SYSDATE,
                message = v_message;
        --
        -- commit information
        --
        COMMIT;

    ELSIF (LENGTH(v_client_version) IS NOT NULL)
    AND (LENGTH(v_core_version) IS NULL)
    THEN
        v_message := 'Update to '||v_client_version||' started on '||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||' by '||v_os_user ||' from '|| v_host ||' - '|| v_ip_address;
        UPDATE
        	installation
        SET
        	os_user = v_os_user,
        	host = v_host,
                ip_address = v_ip_address,
                update_date = SYSDATE,
                message = v_message;
        --
        -- commit information
        --
        COMMIT;

    END IF;
    
    --
    -- print information to screen
    --
    dbms_output.put_line( v_message);
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
end;
/
--
-- eof
--
DISCONNECT
