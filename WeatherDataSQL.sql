CREATE TABLE City (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(255),
    country VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT
);

CREATE TABLE Weather (
    weather_id INT PRIMARY KEY,
    city_id INT,
    date DATE,
    temperature FLOAT,
    weather_condition VARCHAR(255),
    FOREIGN KEY (city_id) REFERENCES City(city_id)
);


INSERT INTO City (city_id, city_name, country, latitude, longitude)
VALUES
    (1, 'New York', 'USA', 40.7128, -74.0060),
    (2, 'London', 'UK', 51.5074, -0.1278),
    (3, 'Tokyo', 'Japan', 35.6895, 139.6917),
    (4, 'Sydney', 'Australia', -33.8688, 151.2093),
    (5, 'Moscow', 'Russia', 55.7558, 37.6176),
    (6, 'Rio de Janeiro', 'Brazil', -22.9068, -43.1729),
    (7, 'Cairo', 'Egypt', 30.0444, 31.2357),
    (8, 'Cape Town', 'South Africa', -33.9249, 18.4241),
    (9, 'Mumbai', 'India', 19.0760, 72.8777),
    (10, 'Rome', 'Italy', 41.9028, 12.4964),
    (11, 'Beijing', 'China', 39.9042, 116.4074),
    (12, 'Toronto', 'Canada', 43.651070, -79.347015);


INSERT INTO weather (weather_id, city_id, date, temperature, weather_condition)
VALUES
    (1, 1, '2023-08-07', 27, 'Partly cloudy'),
    (2, 2, '2023-08-07', 18, 'Rainy'),
    (3, 3, '2023-08-07', 32, 'Sunny'),
    (4, 4, '2023-08-07', 24, 'Clear sky'),
    (5, 5, '2023-08-07', 15, 'Cloudy'),
    (6, 6, '2023-08-07', 30, 'Scattered thunderstorms'),
    (7, 7, '2023-08-07', 38, 'Hot and sunny'),
    (8, 8, '2023-08-07', 22, 'Windy'),
    (9, 9, '2023-08-07', 29, 'Humid'),
    (10, 10, '2023-08-07', 26, 'Partly sunny'),
    (11, 11, '2023-08-07', 22, 'Hazy'),
    (12, 12, '2023-08-07', 23, 'Partly cloudy');
    
    
-- Get weather information for a specific city on a particular date

select * from weather
where city_id=1 and '2023-08-07';

-- Find the average temperature for a given city over a specified time range
select avg(temperature) as avg_temperature from weather
where city_id=1 and date between '2023-08-01' and '2023-08-07';

-- Identify cities with the highest and lowest temperatures recorded
select city_name, max(temperature) as highest_temperature from city
join weather on city.city_id=weather.city_id
group by city_name
order by highest_temperature desc
limit 1;
  
select city_name, min(temperature) as lowest_temperature from city
join weather on city.city_id=weather.city_id
group by city_name
order by lowest_temperature asc
limit 1;

-- Upadte the weather condition for a specific city on a specific date
update weather
set weather_condition='clear sky'
where city_id=1 and date ='2023-08-07';

-- Modify the temperature for a particular city on a given date
update weather 
set temperature=30
where city_id=2 and date='2023-08-07';

-- Remove a city and its related weather records from the database
delete from city where city_id=3; 
delete from weather where city_id=3;

-- Find the cities with the most frequent weatherr conditon
select city_name, weather_condition, count(*) as frequency
from city
join weather on city.city_id=weather.city_id
group by city_name, weather_condition
order by frequency desc;

-- Calculate the average temperature for each month in a specific city:
select city_name, month(date) as month, avg(temperature) as avg_temperature
from city
join weather on city.city_id=weather.city_id
where city.city_id=1
group by city_name, month
order by month;

-- Find the top N cities with the highest temperature recorded:
select city_name, max(temperature) as highest_temperature
from city
join weather on city.city_id= weather.city_id
group by city_name
order by highest_temperature desc
limit 5;

-- nIdentify the correlation between temperature and weather alter
SELECT weather_condition, AVG(temperature) AS avg_temperature
FROM Weather
GROUP BY weather_condition
ORDER BY avg_temperature DESC;

-- Calculate the average temperature deviation from the yearly average for each city:
SELECT city_name, AVG(temperature) - (
  SELECT AVG(temperature)
  FROM Weather
  WHERE city_id = City.city_id
) AS temp_deviation
FROM City
JOIN Weather ON City.city_id = Weather.city_id
GROUP BY city_name;

-- Get the number of days with extreme temperatures (above a threshold) for each city:
SELECT city_name, COUNT(*) AS extreme_days
FROM City
JOIN Weather ON City.city_id = Weather.city_id
WHERE temperature > 30
GROUP BY city_name;

