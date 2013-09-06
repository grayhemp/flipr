-- Verify flips

BEGIN;

SELECT flip_id, nickname, body, timestamp
FROM flipr.flips
WHERE false;

ROLLBACK;
