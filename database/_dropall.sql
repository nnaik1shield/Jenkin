--
-- _DROPALL.sql - recursively drop all objects in the current schema
--
-- WARNING - There is no confirmation, make sure this is what you want to do!
--
--CLEAR SCREEN
PROMPT
SHOW USER
PROMPT
PROMPT Disabling all Foreign Keys...
PROMPT
@@_disable.sql
PROMPT
PROMPT Truncating all user tables...
PROMPT
@@_truncate.sql
PROMPT
PROMPT Dropping all user objects...
PROMPT
@@_drop.sql
PROMPT
PROMPT _DROPALL complete!
PROMPT
--
-- EOF
