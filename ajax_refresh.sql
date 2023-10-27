/* Formatted on 2007/09/27 12:26 (Formatter Plus v4.8.0) */
/* ajax_refresh.sql*/
DISCONNECT
UNDEFINE md_connect
UNDEFINE api_connect
DEFINE md_connect = '&1'
DEFINE api_connect = '&2'

CONNECT &md_connect

SET SERVEROUTPUT ON SIZE UNLIMITED

BEGIN
   FOR vrule IN (SELECT *
                   FROM rule)
   LOOP
      sp_update_rule_input_map (vrule.rule_id);
   END LOOP;

   COMMIT;
END;
/

DISCONNECT

CONNECT &api_connect

SET SERVEROUTPUT ON SIZE UNLIMITED
--

BEGIN
   pkg_os_wf_client_rules.sp_ui_rule_input_update;
END;
/

COMMIT;

DISCONNECT;
EXIT;
/
