-- Deploy flips

BEGIN;

CREATE TABLE flipr.flips (
    flip_id serial PRIMARY KEY,
    nickname text NOT NULL
        REFERENCES flipr.users (nickname) ON DELETE CASCADE ON UPDATE CASCADE,
    body text,
    timestamp timestamp with time zone NOT NULL DEFAULT now()
);

COMMIT;
