-- -----------------------------------------------------------------
-- Question 1 How many accidents have occured in urban areas vs rural ares?
SELECT Area,Count(Area) as countForAccidents
From accident
Group by area
ORDER BY countForAccidents DESC
;

-- Question 2 Which day of the week has the highest number of accidents?
SELECT Day,Count(Day) countForAccidents
FROM accident
GROUP BY Day
ORDER BY countForAccidents DESC;

-- Question 3 What is the average age of vehicles involved in accidents based on their types?
SELECT VehicleType,AVG(AgeVehicle) as avgAgeVehicle
FROM vehicle
WHERE AgeVehicle is not null
GROUP BY VehicleType
ORDER BY avgAgeVehicle DESC;


-- Question 4 Can we identify any trends in accidents based on the age of vehicles  involved?
SELECT AgeCategory,avg(AgeVehicle) as avgAge,COUNT(AccidentIndex) countForAccidents
FROM (
	SELECT AccidentIndex,AgeVehicle,
	CASE 
		WHEN AgeVehicle BETWEEN 0 AND 5 THEN 'New'
		WHEN AgeVehicle BETWEEN 6 AND 10 THEN 'Regular'
	ELSE 'Old'
	END as AgeCategory
	From vehicle
	WHERE AgeVehicle IS NOT NULL
	) as subQuery
Group by AgeCategory
ORDER BY countForAccidents DESC;


-- Question 5 Are there any specific weather conditions that contribute to severe accidents?
DECLARE @Severity varchar(100)
SET @Severity='Fatal';

SELECT WeatherConditions,Count(Severity) countForAccidents
FROM accident
WHERE Severity=@Severity
GROUP BY WeatherConditions
ORDER BY countForAccidents DESC
;

-- Question 6 Do accidents often involve impacts on the left hand side of the vehicle?
SELECT LeftHand,Count(LeftHand) as countForAccidents
FROM vehicle
GROUP BY LeftHand
;

-- Question 7 Are there any relations between the purpose of the journey and severity of the accidents?


SELECT JourneyPurpose,Count(JourneyPurpose)
FROM accident
INNER JOIN vehicle
ON accident.AccidentIndex=vehicle.AccidentIndex
GROUP BY JourneyPurpose
;
