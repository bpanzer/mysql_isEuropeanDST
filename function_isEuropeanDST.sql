-- Version 1.0, 29.01.2022
SET sql_mode = 'TRADITIONAL';
SET GLOBAL sql_mode = 'TRADITIONAL';

DELIMITER //

CREATE OR REPLACE FUNCTION isEuropeanDST(year SMALLINT, month TINYINT, day TINYINT, dow TINYINT)
RETURNS BOOLEAN
-- input parameters: year, month, day, hour, and DayOfWeek
-- return value: returns true during Daylight Saving Time, else false.
-- remark: this function is not exact as it does not consider the hour.
BEGIN
	DECLARE previousSunday TINYINT;
	IF month<3 || month>10 THEN 
		RETURN FALSE; -- no Daylight Saving Time in Jan, Feb, Nov, Dez
	END IF;
	IF month>3 && month<10 THEN 
		RETURN TRUE;
	END IF;
	SET previousSunday = day-dow;
	IF (month=3) THEN 
		RETURN previousSunday >= 25;
	END IF;
    IF (month=10) THEN 
		RETURN previousSunday < 25;
	END IF;
END;
//
DELIMITER ;
