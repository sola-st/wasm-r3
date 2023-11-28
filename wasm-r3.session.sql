-- @block
CREATE TABLE Details (
    name VARCHAR(255) PRIMARY KEY,
    phase VARCHAR(255) NOT NULL,
    description TEXT
);

-- @block
INSERT INTO Details (name, phase, description)
VALUES
    ('user interaction', 'record', 'The time it takes to start the chromium browser and open the webpage until the \'load\' event is fired.'),
    ('stop', 'record', 'The time it takes to stop the recording, from when the user stopped the recording until all data is downloaded from the browser and the browser is closed.');

-- @block
SELECT name, phase FROM Details

-- @block
DROP TABLE Details;