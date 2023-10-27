--
-- drop_fk.sql -- script to drop all foreign keys
--
SET FEEDBACK OFF
DECLARE
   CURSOR c_fk
   IS
      SELECT   table_name,
               constraint_name
          FROM user_constraints
         WHERE constraint_type = 'R'
      ORDER BY 1;
   v_sql   VARCHAR2 (200);
BEGIN
   FOR r_fk IN c_fk
   LOOP
      BEGIN
         v_sql := 'ALTER TABLE ' || LOWER(r_fk.table_name) || ' DROP CONSTRAINT ' || LOWER(r_fk.constraint_name);

         --dbms_output.put_line( v_sql || ';');
         EXECUTE IMMEDIATE v_sql;
      EXCEPTION
         WHEN OTHERS
         THEN
            dbms_output.put_line( v_sql || ' --> ' || TRIM( SQLERRM( SQLCODE ) ) );
      END;
   END LOOP;
EXCEPTION
   WHEN OTHERS
   THEN
      dbms_output.put_line( TRIM( SQLERRM( SQLCODE ) ) );
END;
/
SET FEEDBACK ON
--
-- done
--
