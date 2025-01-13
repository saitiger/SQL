-- Dimension Tables

CREATE TABLE Dim_Date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    day_name VARCHAR(10),
    day_of_week INT,
    day_of_year INT,
    week_of_year INT,
    month INT,
    month_name VARCHAR(10),
    quarter INT,
    year INT,
    is_weekend BOOLEAN,
    is_holiday BOOLEAN
);

CREATE TABLE Dim_User (
    user_id INT PRIMARY KEY,
    created_date_id INT REFERENCES Dim_Date(date_id),
    user_name VARCHAR(100),
    user_email VARCHAR(100),
    user_phone VARCHAR(20),
    country VARCHAR(50),
    city VARCHAR(50),
    age_group VARCHAR(20),
    gender VARCHAR(10),
    is_active BOOLEAN
);

CREATE TABLE Dim_Plan (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),  -- lite, pro, enterprise
    plan_price DECIMAL(10,2),
    max_concurrent_streams INT,
    video_quality VARCHAR(20),  -- SD, HD, 4K
    can_download BOOLEAN,
    valid_from_date_id INT REFERENCES Dim_Date(date_id),
    valid_to_date_id INT REFERENCES Dim_Date(date_id)
);

CREATE TABLE Dim_Subscription (
    subscription_id INT PRIMARY KEY,
    user_id INT REFERENCES Dim_User(user_id),
    plan_id INT REFERENCES Dim_Plan(plan_id),
    subscription_type VARCHAR(20),  -- monthly, yearly
    start_date_id INT REFERENCES Dim_Date(date_id),
    end_date_id INT REFERENCES Dim_Date(date_id),
    is_active BOOLEAN,
    payment_method VARCHAR(50),
    auto_renewal BOOLEAN
);

CREATE TABLE Dim_Content (
    content_id INT PRIMARY KEY,
    content_name VARCHAR(200),
    content_type VARCHAR(50),  -- movie, series, documentary
    content_category VARCHAR(50),  -- kids, adult, family
    primary_genre VARCHAR(50),
    secondary_genre VARCHAR(50),
    release_date_id INT REFERENCES Dim_Date(date_id),
    run_length_minutes INT,
    age_rating VARCHAR(10),
    language VARCHAR(50),
    is_original BOOLEAN,
    season_number INT,  -- NULL for movies
    episode_number INT  -- NULL for movies
);

CREATE TABLE Dim_Device (
    device_id INT PRIMARY KEY,
    device_type VARCHAR(50),  -- smart TV, mobile, tablet, web
    device_brand VARCHAR(50),
    operating_system VARCHAR(50),
    app_version VARCHAR(20)
);

-- Fact Tables

CREATE TABLE Fact_Streaming (
    streaming_id INT PRIMARY KEY,
    user_id INT REFERENCES Dim_User(user_id),
    content_id INT REFERENCES Dim_Content(content_id),
    subscription_id INT REFERENCES Dim_Subscription(subscription_id),
    device_id INT REFERENCES Dim_Device(device_id),
    streaming_date_id INT REFERENCES Dim_Date(date_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    duration_minutes INT,
    pause_count INT,
    buffer_count INT,
    quality_switches INT,
    max_quality_played VARCHAR(20),
    is_downloaded BOOLEAN,
    watch_completion_rate DECIMAL(5,2),
    user_rating INT
);

CREATE TABLE Fact_User_Activity (
    activity_id INT PRIMARY KEY,
    user_id INT REFERENCES Dim_User(user_id),
    date_id INT REFERENCES Dim_Date(date_id),
    device_id INT REFERENCES Dim_Device(device_id),
    login_count INT,
    search_count INT,
    list_additions INT,
    profile_switches INT
);
