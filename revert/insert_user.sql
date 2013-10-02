-- Revert insert_user

BEGIN;

DROP FUNCTION flipr.insert_user(text, text);

COMMIT;
