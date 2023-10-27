CREATE OR REPLACE 
PACKAGE PKG_OS_GRANT
-------------
-- $Workfile:   pkg_os_grant.sql  $
-- $Revision: 2427 $
--	$Author: achenard $
--	  $Date: 2014-04-29 22:32:52 +0530 (Tue, 29 Apr 2014) $
-------------
AS
	PROCEDURE grant_s (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_sr (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_sriud (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_seq (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_vw (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_rd (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_ro (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_rw (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE grant_wr (i_user IN VARCHAR2 DEFAULT NULL);

	--
	PROCEDURE revoke_s (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_sr (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_sriud (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_seq (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_vw (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_rd (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_ro (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_rw (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE revoke_wr (i_user IN VARCHAR2 DEFAULT NULL);

	--
	PROCEDURE revoke_all (i_user IN VARCHAR2 DEFAULT NULL);

	--
	PROCEDURE syn (i_user IN VARCHAR2 DEFAULT NULL);

	PROCEDURE no_syn (i_user IN VARCHAR2 DEFAULT NULL);

	--
	PROCEDURE show_version;
END pkg_os_grant;												  --
/

CREATE OR REPLACE 
PACKAGE BODY PKG_OS_GRANT
-------------
-- $Workfile:   pkg_os_grant.sql  $
-- $Revision: 2427 $
--	$Author: achenard $
--	  $Date: 2014-04-29 22:32:52 +0530 (Tue, 29 Apr 2014) $
-------------
AS
--------------------------------------------------------------------------------
--
-- Grant SELECT on all tables to a user
--
	PROCEDURE grant_s (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				   'GRANT SELECT ON ' || r_tables.tname || ' TO ' || i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					--
					-- Eat the error for overflow of IOT's
					--
					IF SQLCODE = -25191
					THEN
						NULL;
					ELSE
						DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
						DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END IF;
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges granted to ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Grant SELECT,REFERECES on all tables to a user
--
	PROCEDURE grant_sr (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				   'GRANT SELECT, REFERENCES ON '
				|| r_tables.tname
				|| ' TO '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					--
					-- Eat the error for overflow of IOT's
					--
					IF SQLCODE = -25191
					THEN
						NULL;
					ELSE
						DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
						DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END IF;
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges granted to ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Grant SELECT,REFERENCES,INSERT,UPDATE,DELETE on all tables to a user
--
	PROCEDURE grant_sriud (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				   'GRANT SELECT, REFERENCES, INSERT, UPDATE, DELETE ON '
				|| r_tables.tname
				|| ' TO '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					--
					-- Eat the error for overflow of IOT's
					--
					IF SQLCODE = -25191
					THEN
						NULL;
					ELSE
						DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
						DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END IF;
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges granted to ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Grant SELECT on all sequences to a user
--
	PROCEDURE grant_seq (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_seq
		IS
			SELECT sequence_name
			  FROM seq;
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_seq IN c_seq LOOP
			v_sql :=
				'GRANT SELECT ON ' || r_seq.sequence_name || ' TO '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges granted to ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Grant SELECT on all views to a user
--
	PROCEDURE grant_vw (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_vw
		IS
			SELECT view_name
			  FROM user_views;
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_vw IN c_vw LOOP
			v_sql :=
				   'GRANT SELECT ON ' || r_vw.view_name || ' TO ' || i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges granted to ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
	PROCEDURE grant_rd (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		grant_sr (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE grant_ro (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		grant_sr (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE grant_rw (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		grant_sriud (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE grant_wr (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		grant_sriud (i_user);
	END;

--------------------------------------------------------------------------------
--
-- Revoke SELECT on all tables from a user
--
	PROCEDURE revoke_s (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				'REVOKE SELECT ON ' || r_tables.tname || ' FROM ' || i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Revoke SELECT,REFERENCES on all tables from a user
--
	PROCEDURE revoke_sr (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				   'REVOKE SELECT, REFERENCES ON '
				|| r_tables.tname
				|| ' FROM '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Revoke SELECT,REFERENCES,INSERT,UPDATE,DELETE on all tables from a user
--
	PROCEDURE revoke_sriud (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT tname
			  FROM tab
			 WHERE tabtype = 'TABLE';
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_tables IN c_tables LOOP
			v_sql :=
				   'REVOKE SELECT, REFERENCES, INSERT, UPDATE, DELETE ON '
				|| r_tables.tname
				|| ' FROM '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Revoke SELECT on all sequences from a user
--
	PROCEDURE revoke_seq (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_seq
		IS
			SELECT sequence_name
			  FROM seq;
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_seq IN c_seq LOOP
			v_sql :=
				   'REVOKE SELECT ON '
				|| r_seq.sequence_name
				|| ' FROM '
				|| i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
--
-- Revoke SELECT on all views from a user
--
	PROCEDURE revoke_vw (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_vw
		IS
			SELECT view_name
			  FROM user_views;
	BEGIN
		--
		-- exit if no user name given
		--
		IF i_user IS NULL
		THEN
			RETURN;
		END IF;

		FOR r_vw IN c_vw LOOP
			v_sql :=
				'REVOKE SELECT ON ' || r_vw.view_name || ' FROM ' || i_user;

			BEGIN
				EXECUTE IMMEDIATE v_sql;

				i := i + 1;
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END LOOP;

		DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from ' || i_user));
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
	END;

--------------------------------------------------------------------------------
	PROCEDURE revoke_rd (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		revoke_sr (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE revoke_ro (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		revoke_sr (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE revoke_rw (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		revoke_sriud (i_user);
	END;

--------------------------------------------------------------------------------
	PROCEDURE revoke_wr (i_user IN VARCHAR2 DEFAULT NULL)
	AS
	BEGIN
		revoke_sriud (i_user);
	END;

--------------------------------------------------------------------------------
--
-- Revoke all privileges from a user, or all users
--
	PROCEDURE revoke_all (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_privs
		IS
			SELECT   table_name, PRIVILEGE
			    FROM user_tab_privs_made
			   WHERE UPPER (grantee) = UPPER (i_user)
			ORDER BY table_name, PRIVILEGE;

		CURSOR c_all_privs
		IS
			SELECT   grantee, table_name, PRIVILEGE
			    FROM user_tab_privs_made
			ORDER BY grantee, table_name, PRIVILEGE;
	BEGIN
		--
		-- if no user specified, revoke all grants to all users.
		--
		IF i_user IS NULL
		THEN
			BEGIN
				FOR r_all_privs IN c_all_privs LOOP
					v_sql :=
						   'REVOKE '
						|| r_all_privs.PRIVILEGE
						|| ' ON '
						|| r_all_privs.table_name
						|| ' FROM '
						|| r_all_privs.grantee;

					BEGIN
						EXECUTE IMMEDIATE v_sql;

						i := i + 1;
					EXCEPTION
						WHEN OTHERS
						THEN
							DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
							DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked'));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		--
		-- else if user specified, revoke all grants to that user.
		--
		ELSE
			BEGIN
				FOR r_privs IN c_privs LOOP
					v_sql :=
						   'REVOKE '
						|| r_privs.PRIVILEGE
						|| ' ON '
						|| r_privs.table_name
						|| ' FROM '
						|| i_user;

					BEGIN
						EXECUTE IMMEDIATE v_sql;

						i := i + 1;
					EXCEPTION
						WHEN OTHERS
						THEN
							DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
							DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' privileges revoked from '
						|| i_user));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END IF;
	END;

--------------------------------------------------------------------------------
--
-- create synonyms based on what a user has granted you
--
	PROCEDURE syn (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i		    NUMBER						  := 0;
		j		    NUMBER						  := 0;
		v_sql	    VARCHAR2 (255);
		v_count	    NUMBER;
		v_name	    user_tab_privs_recd.table_name%TYPE;
		v_owner	    user_tab_privs_recd.grantor%TYPE;
		v_old_owner   VARCHAR2 (30);

		CURSOR c_tables
		IS
			SELECT DISTINCT grantor owner, table_name NAME
					 FROM user_tab_privs_recd
					WHERE UPPER (owner) = UPPER (i_user)
			MINUS
			SELECT DISTINCT table_owner owner1, table_name name1
					 FROM syn
					WHERE UPPER (table_owner) = UPPER (i_user)
				  ORDER BY NAME;

		CURSOR c_all_tables
		IS
			SELECT DISTINCT grantor owner, table_name NAME
					 FROM user_tab_privs_recd
			MINUS
			SELECT DISTINCT table_owner owner, table_name NAME
					 FROM syn
				  ORDER BY owner, NAME;
	BEGIN
		--
		-- if no user name given, make synonyms to all granted objects
		--
		IF i_user IS NULL
		THEN
			BEGIN
				FOR r_all_tables IN c_all_tables LOOP
					v_owner := r_all_tables.owner;
					v_name := r_all_tables.NAME;

					--
					-- Check if a synonym exists already
					--
					SELECT COUNT (1)
					  INTO v_count
					  FROM syn
					 WHERE synonym_name = v_name;

					--
					-- If count is 1, then synonym exists to another user!
					--
					IF v_count = 1
					THEN
						SELECT table_owner
						  INTO v_old_owner
						  FROM syn
						 WHERE synonym_name = v_name;

						DBMS_OUTPUT.put_line
							    (TRIM (v_owner
								|| '.'
								|| v_name
								|| ': synonym already exists for '
								|| v_old_owner
								|| '.'
								|| v_name));
						j := j + 1;
					--
					-- if count is 0, create the synonym
					--
					ELSE
						v_sql :=
							   'CREATE SYNONYM '
							|| r_all_tables.NAME
							|| ' FOR '
							|| r_all_tables.owner
							|| '.'
							|| r_all_tables.NAME;

						BEGIN
							EXECUTE IMMEDIATE v_sql;

							i := i + 1;
						EXCEPTION
							WHEN OTHERS
							THEN
                                        IF SQLCODE = -955 THEN --ORA-00955: name is already used by an existing object
                                             NULL;
                                        else
                                             DBMS_OUTPUT.put_line (TRIM (v_sql
                                                       || ';'));
                                             DBMS_OUTPUT.put_line
                                                             (TRIM (SQLERRM (SQLCODE)));
                                        end if;
						END;
					END IF;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' synonyms created'));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		--
		-- else if user name given, make synonyms to all granted objects from that user
		--
		ELSE
			BEGIN
				FOR r_tables IN c_tables LOOP
					v_owner := r_tables.owner;
					v_name := r_tables.NAME;

					--
					-- Check if a synonym exists already
					--
					SELECT COUNT (1)
					  INTO v_count
					  FROM syn
					 WHERE synonym_name = v_name;

					--
					-- If count is 1, then synonym exists to another user!
					--
					IF v_count = 1
					THEN
						SELECT table_owner
						  INTO v_old_owner
						  FROM syn
						 WHERE synonym_name = v_name;

						DBMS_OUTPUT.put_line
							    (TRIM (v_owner
								|| '.'
								|| v_name
								|| ': synonym already exists for '
								|| v_old_owner
								|| '.'
								|| v_name));
						j := j + 1;
					--
					-- if count is 0, create the synonym
					--
					ELSE
						v_sql :=
							   'CREATE SYNONYM '
							|| r_tables.NAME
							|| ' FOR '
							|| i_user
							|| '.'
							|| r_tables.NAME;

						BEGIN
							EXECUTE IMMEDIATE v_sql;

							i := i + 1;
						EXCEPTION
							WHEN OTHERS
							THEN
                                        IF SQLCODE = -955 THEN --ORA-00955: name is already used by an existing object
                                             NULL;
                                        else
                                             DBMS_OUTPUT.put_line (TRIM (v_sql
                                                       || ';'));
                                             DBMS_OUTPUT.put_line
                                                             (TRIM (SQLERRM (SQLCODE)));
                                        end if;
						END;
					END IF;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' synonyms to ' || i_user
						|| ' created'));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END IF;

		IF j <> 0
		THEN
			DBMS_OUTPUT.put_line
					(TRIM (j
					|| ' synonyms already exist to a different target'));
		END IF;
	END;

--------------------------------------------------------------------------------
--
-- drop all synonyms to a user, or all users
--
	PROCEDURE no_syn (i_user IN VARCHAR2 DEFAULT NULL)
	AS
		i	   NUMBER 	   := 0;
		v_sql   VARCHAR2 (255);

		CURSOR c_tables
		IS
			SELECT DISTINCT table_owner, synonym_name NAME
					 FROM syn
					WHERE UPPER (table_owner) = UPPER (i_user)
				  ORDER BY synonym_name;

		CURSOR c_all_tables
		IS
			SELECT DISTINCT table_owner, synonym_name NAME
					 FROM syn
				  ORDER BY synonym_name;
	BEGIN
		--
		-- if no user name given, remove all synonyms
		--
		IF i_user IS NULL
		THEN
			BEGIN
				FOR r_all_tables IN c_all_tables LOOP
					v_sql := 'DROP   SYNONYM ' || r_all_tables.NAME;

					BEGIN
						EXECUTE IMMEDIATE v_sql;

						i := i + 1;
					EXCEPTION
						WHEN OTHERS
						THEN
							DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
							DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' synonyms dropped'));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		--
		-- else if user name given, remove all synonyms to that user
		--
		ELSE
			BEGIN
				FOR r_tables IN c_tables LOOP
					v_sql := 'DROP   SYNONYM ' || r_tables.NAME;

					BEGIN
						EXECUTE IMMEDIATE v_sql;

						i := i + 1;
					EXCEPTION
						WHEN OTHERS
						THEN
							DBMS_OUTPUT.put_line (TRIM (v_sql || ';'));
							DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
					END;
				END LOOP;

				DBMS_OUTPUT.put_line (TRIM (i || ' synonyms to ' || i_user
						|| ' dropped'));
			EXCEPTION
				WHEN OTHERS
				THEN
					DBMS_OUTPUT.put_line (TRIM (SQLERRM (SQLCODE)));
			END;
		END IF;
	END;

-----------------------------------------------------------------------------------------------------------------------------------------------------
	PROCEDURE show_version
	IS
	BEGIN
		DBMS_OUTPUT.put_line
						('$Workfile:   pkg_os_grant.sql  $');
		DBMS_OUTPUT.put_line ('$Revision: 2427 $');
		DBMS_OUTPUT.put_line ('$Author: achenard $');
		DBMS_OUTPUT.put_line ('$Date: 2014-04-29 22:32:52 +0530 (Tue, 29 Apr 2014) $');
	EXCEPTION
		WHEN OTHERS
		THEN
			DBMS_OUTPUT.put_line (SQLERRM (SQLCODE));
	END show_version;
-----------------------------------------------------------------------------------------------------------------------------------------------------
END pkg_os_grant;
/
