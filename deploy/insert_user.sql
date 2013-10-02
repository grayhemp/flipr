-- Deploy insert_user
-- requires: users
-- requires: appschema

BEGIN;

CREATE OR REPLACE FUNCTION flipr.insert_user(
    nickname text,
    password text)
RETURNS void LANGUAGE 'sql' SECURITY DEFINER AS $$
    INSERT INTO flipr.users VALUES($1, md5($2));
$$;

COMMIT;
