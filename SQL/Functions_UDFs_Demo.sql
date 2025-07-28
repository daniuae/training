/*
Step #1
*/
CREATE OR REPLACE FUNCTION add_numbers(x int, y int)
RETURNS int
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN x + y;
END;
$$;

/*Step #2*/
SELECT add_numbers(5, 3);  -- Returns 8


CREATE OR REPLACE FUNCTION greet_user(name TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    greeting TEXT;
BEGIN
    IF name IS NULL OR name = '' THEN
        RETURN 'Hello, Guest!';
    ELSE
        greeting := 'Hello, ' || name || '!';
        RETURN greeting;
    END IF;
END;
$$;


SELECT greet_user('Panda');


