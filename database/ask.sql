--
-- Prompt for variables
--
PROMPT ***
PROMPT *** Warning: No target file was specified
PROMPT *** This script will require the following parameters to execute:
PROMPT ***
PROMPT *** - metadata schema username
PROMPT *** - metadata schema password
PROMPT *** - storage schema username
PROMPT *** - storage schema password
PROMPT *** - API schema username
PROMPT *** - API schema password
--PROMPT *** - DBA username (for import)
--PROMPT *** - DBA password (for import)
PROMPT *** - Oracle instance TNS name (MUST BE LISTED IN tnsnames.ora!)
PROMPT *** - Folder to use for log file output
PROMPT ***
PROMPT *** You will now be prompted for these parameters interactively
PROMPT ***
--
PROMPT
PROMPT Enter the METADATA schema username (<ENTER> = &&FROM_MD_USER), or CTRL-C to quit:
ACCEPT MD_USER CHAR DEFAULT '&&FROM_MD_USER' PROMPT '--> '
PROMPT Using: &&MD_USER
PROMPT
PROMPT Enter the METADATA schema password (<ENTER> = &&MD_USER), or CTRL-C to quit:
PROMPT NOTE: the password will NOT display on the screen
ACCEPT MD_PASS CHAR DEFAULT '&&MD_USER' PROMPT '--> ' HIDE
--
PROMPT
PROMPT Enter the STORAGE schema username (<ENTER> = &&FROM_ST_USER), or CTRL-C to quit:
ACCEPT ST_USER CHAR DEFAULT '&&FROM_ST_USER' PROMPT '--> '
PROMPT Using: &&ST_USER
PROMPT
PROMPT Enter the STORAGE schema password (<ENTER> = &&ST_USER), or CTRL-C to quit:
PROMPT NOTE: the password will NOT display on the screen
ACCEPT ST_PASS CHAR DEFAULT '&&ST_USER' PROMPT '--> ' HIDE
--
PROMPT
PROMPT Enter the API schema username (<ENTER> = &&FROM_API_USER), or CTRL-C to quit:
ACCEPT API_USER CHAR DEFAULT '&&FROM_API_USER' PROMPT '--> '
PROMPT Using: &&API_USER
PROMPT
PROMPT Enter the API schema password (<ENTER> = &&API_USER), or CTRL-C to quit:
PROMPT NOTE: the password will NOT display on the screen
ACCEPT API_PASS CHAR DEFAULT '&&API_USER' PROMPT '--> ' HIDE
--
--PROMPT
--PROMPT Enter the DBA username (<ENTER> = SYSTEM), or CTRL-C to quit:
--ACCEPT DBA_USER CHAR DEFAULT 'SYSTEM' PROMPT '--> '
--PROMPT Using: &&DBA_USER
--PROMPT
--PROMPT Enter the DBA password (<ENTER> = MANAGER), or CTRL-C to quit:
--PROMPT NOTE: the password will NOT display on the screen
--ACCEPT DBA_PASS CHAR DEFAULT 'MANAGER' PROMPT '--> ' HIDE
--
PROMPT
PROMPT Enter the database instance name (<ENTER> = DRAGON), or CTRL-C to quit:
ACCEPT DB_NAME CHAR DEFAULT 'DRAGON' PROMPT '--> '
PROMPT Using: &&DB_NAME
--
PROMPT
PROMPT Enter the folder to use for the log files (<ENTER> = &&LOGDIR), or CTRL-C to quit:
ACCEPT LOGDIR CHAR DEFAULT '&&LOGDIR' PROMPT '--> '
PROMPT Using: &&LOGDIR
--
PROMPT
