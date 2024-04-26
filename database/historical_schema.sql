DROP TABLE IF EXISTS historical_data.station_performance;
DROP TABLE IF EXISTS historical_data.operator_performance;

CREATE TABLE historical_data.station_performance(
    station_performance_id SERIAL PRIMARY KEY,
    station_id INT REFERENCES public.stations(station_id),
    day DATE NOT NULL,
    cancellation_count INT DEFAULT 0,
    delay_1m_count INT DEFAULT 0, 
    delay_5m_count INT DEFAULT 0, 
    avg_delay DECIMAL(4,2) DEFAULT 0,
    arrival_count INT NOT NULL, 
    common_cancel_code varchar(2) 
);

CREATE TABLE historical_data.operator_performance(
    operator_performance_id SERIAL PRIMARY KEY,
    operator_id INT REFERENCES public.operators(operator_id),
    day DATE NOT NULL,
    cancellation_count INT DEFAULT 0,
    delay_1m_count INT DEFAULT 0, 
    delay_5m_count INT DEFAULT 0, 
    avg_delay DECIMAL(4,2) DEFAULT 0,
    arrival_count INT NOT NULL, 
    common_cancel_code varchar(2) 
);