SET SERVEROUTPUT ON SIZE 1000000
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PROMPT     $Workfile:   compile.sql  $
PROMPT     $Revision: 2427 $
PROMPT     $Date: 2014-04-29 22:32:52 +0530 (Tue, 29 Apr 2014) $
PROMPT 	   $Author: achenard $
PROMPT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
** http://www.oracle.com/technology/oramag/oracle/06-may/o36plsql.html
*/
-- extracted this nugget and modified for our use.
declare
                cursor c_invalid_pkg_name_list
                is
                                select distinct object_name as name
                                                                 from user_objects
                                                                where /* object_name like 'PKG\_OS\_%' escape '\'
                                                                  and object_type in ('PACKAGE', 'PACKAGE BODY')
                                                                  and */ status = 'INVALID'
                                                  order by object_name asc;

                cursor c_invalid_object_name_list
                is
                                select object_name as name, object_type as type
                                  from user_objects
                                 where status = 'INVALID'
           order by 1, 2;

                r_pkg_name      sys.user_source.name%type;
                v_num_pkgs      integer;
                v_start_time      pls_integer;
begin
                dbms_output.put_line (user
                                || '@'
                                || sys_context ('USERENV', 'DB_NAME')
                                || ' at '
                                || to_char (sysdate, 'YYYY-MM-DD HH24:MI:SS'));
                --
                -- list invalid packages.
                --
                v_num_pkgs := 0;

                for r_pkg_name in c_invalid_pkg_name_list loop
--                                dbms_output.put_line (r_pkg_name.name || ' Invalid package.');
                                v_num_pkgs := c_invalid_pkg_name_list%rowcount;
                end loop;

                if v_num_pkgs != 0
                then
--                             dbms_output.put_line (v_num_pkgs || ' invalid packages. Should be 0.');
                                --
                                -- recompile. keep time.
                                v_start_time := dbms_utility.get_cpu_time;
                                dbms_utility.compile_schema (
                                                user,
                                                -- Comment out following line for versions earlier than 10g
                                                compile_all                           => false,
                                                reuse_settings   => true
                                );
                                dbms_output.put_line ('Elapsed CPU time for schema recompile: '
                                                || to_char ((dbms_utility.get_cpu_time - v_start_time)*(1/100))
                                                || ' secs');
                end if;

                                --
                -- list invalid objects. should be none!
                --
                v_num_pkgs := 0;
				dbms_output.put_line (' ');
				dbms_output.put_line ('=============================================================================');
				dbms_output.put_line (' ');
                for r_pkg_name in c_invalid_object_name_list loop
                                dbms_output.put_line ('ORA-24344: success with compilation error ' || r_pkg_name.name || ' ('||r_pkg_name.type||')');
                                v_num_pkgs := c_invalid_object_name_list%rowcount;
                end loop;
				dbms_output.put_line (' ');
				dbms_output.put_line ('=============================================================================');
				dbms_output.put_line (' ');
                dbms_output.put_line (v_num_pkgs || ' invalid objects. Should be 0.');
end;
/


SET feedback ON
