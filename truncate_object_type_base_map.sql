/* Formatted on 2007/09/27 12:26 (Formatter Plus v4.8.0) */
/* ajax_refresh.sql*/
DISCONNECT
UNDEFINE st_connect
DEFINE st_connect = '&1'

CONNECT &st_connect
TRUNCATE TABLE OBJECT_TYPE_BASE_MAP;
COMMIT;
DISCONNECT;
EXIT;
/
