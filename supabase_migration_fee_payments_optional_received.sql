-- Optional: make received_by nullable so payments can be recorded without users table id.
-- Run in Supabase SQL Editor only if you need to record payments without linking to users(id).
ALTER TABLE fee_payments ALTER COLUMN received_by DROP NOT NULL;
