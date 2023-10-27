--
UPDATE installation
   SET md_version = '&1';
UPDATE installation
   SET st_version = '&1';
UPDATE installation
   SET api_version = '&1';
COMMIT;
--
-- done
--
exit
