SET client_min_messages TO warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;
SET search_path TO flipr,public;

BEGIN;

SELECT plan(11);

SELECT has_function('insert_user');

SELECT has_function('insert_user', array['text', 'text']);

SELECT function_lang_is('insert_user', array['text', 'text'], 'sql');

SELECT function_returns('insert_user', array['text', 'text'], 'void');

SELECT volatility_is('insert_user', array['text', 'text'], 'volatile');

SELECT lives_ok(
    $$ SELECT insert_user('theory', 'foo') $$,
    'Insert a user'
);

SELECT row_eq(
    'SELECT * FROM users',
    ROW('theory', md5('foo'),now())::users,
    'The user should have been inserted'
);

SELECT lives_ok(
    $$ SELECT insert_user('strongrrl', 'w00t') $$,
    'Insert another user'
);
SELECT bag_eq(
    'SELECT * FROM users',
    $$ VALUES
        ('theory',    md5('foo'),  now()),
        ('strongrrl', md5('w00t'), now())
    $$,
    'Both users should be present'
);

SELECT throws_ok(
    $$ SELECT insert_user('theory', 'ha*ha') $$,
    23505, -- duplicate key violation
    NULL,  -- localized error message
    'Should get an error for duplicate nickname'
);

SELECT bag_eq(
    'SELECT * FROM users',
    $$ VALUES
        ('theory',    md5('foo'),  now()),
        ('strongrrl', md5('w00t'), now())
    $$,
    'Should still have just the two users'
);

SELECT finish();

ROLLBACK;
