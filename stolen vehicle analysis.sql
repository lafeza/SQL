copy public.stolen_vehicles from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Motor Vehicle Thefts\stolen_vehicles.csv' delimiter ',' csv header;

ALTER TABLE stolen_vehicles ALTER COLUMN date_stolen TYPE DATE using TO_DATE(date_stolen, 'DD/MM/YYYY');

select * from stolen_vehicles;

copy public.location from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Motor Vehicle Thefts\location.csv' delimiter ',' csv header;

select * from location;

copy public.make_details from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Motor Vehicle Thefts\make_details.csv' delimiter ',' csv header;

select * from make_details;

--1. Day of the week where vehicles are most often or least stolen

SELECT 
    TO_CHAR(date_stolen, 'Day') AS day_of_week,
    COUNT(*) AS theft_count
FROM 
    stolen_vehicles
GROUP BY 
    TO_CHAR(date_stolen, 'Day')
ORDER BY 
    theft_count DESC;

--2. Vehicles most often and least often stolen by year and region

SELECT 
    TO_CHAR(date_stolen, 'Day') AS stolen_day,
    COUNT(*) AS total_stolen
FROM 
    stolen_vehicles
GROUP BY 
    TO_CHAR(date_stolen, 'Day')
ORDER BY 
    total_stolen DESC;

SELECT 
    TO_CHAR(sv.date_stolen, 'YYYY') AS stolen_year,
    l.region AS region,
    COUNT(*) AS total_stolen
FROM 
    stolen_vehicles sv
JOIN 
    location l ON sv.location_id = l.location_id
GROUP BY 
    TO_CHAR(sv.date_stolen, 'YYYY'),
    l.region
ORDER BY 
    l.region, 
    total_stolen DESC;

--3. Average age of vehicles that are stolen by type

SELECT 
    sv.vehicle_type AS vehicle_type,
AVG(EXTRACT(YEAR FROM sv.date_stolen) - sv.model_year) AS average_age
FROM 
    stolen_vehicles sv
JOIN 
    make_details md ON sv.make_id = md.make_id
WHERE 
    sv.model_year IS NOT NULL
GROUP BY 
    sv.vehicle_type
ORDER BY 
    average_age DESC;

select * from stolen_vehicles;

--4. Regions with most and least number of stolen vehicles

SELECT 
    l.region AS region,
COUNT(sv.vehicle_id) AS total_stolen
FROM 
    stolen_vehicles sv
JOIN 
    location l ON sv.location_id = l.location_id
GROUP BY 
    l.region
ORDER BY 
    total_stolen DESC;

