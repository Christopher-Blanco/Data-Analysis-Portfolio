-- ==============================================================================
-- PROJECT: Global Video Game Market Analysis (1980-2020)
-- CORE ANALYTICAL QUERIES (MySQL)
-- Developer: Christopher Blanco
-- ==============================================================================

USE video_game_analysis;

-- ------------------------------------------------------------------------------
-- 1. GLOBAL SALES ANALYSIS BY GENRE
-- Objective: Visualize how culture influences purchasing patterns by region,
-- and which genres/titles dominate each market.
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    total_sales DESC;

-- ------------------------------------------------------------------------------
-- 2. TOP 10 PUBLISHERS BY GLOBAL SALES (UNITS SOLD)
-- Objective: Identify which leaders and publishers market revenue volume dominate the industry.
-- ------------------------------------------------------------------------------
SELECT 
    publisher, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    publisher
ORDER BY 
    total_sales DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- 3. ANALYSIS OF GLOBAL SOFTWARE SALES BY CONSOLE
-- Objective: Which consoles led software sales, and what business factors explain the ranking?
-- ------------------------------------------------------------------------------
SELECT 
    console, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    console
ORDER BY 
    total_sales DESC;

-- ------------------------------------------------------------------------------
-- 4. TOP 10 BEST-SELLING VIDEO GAMES (BY PLATFORM)
-- Objective: Which titles lead by console, and what business patterns explain their success?
-- ------------------------------------------------------------------------------
SELECT 
    title,
    console,
    total_sales
FROM 
    games
ORDER BY 
    total_sales DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- 5. CONSUMER PREFERENCES: JAPAN (JP)
-- Objective: Which genres lead in Japan, and what cultural/business factors explain these preferences?
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(jp_sales) AS japan_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    japan_sales DESC;

-- ------------------------------------------------------------------------------
-- 6. CONSUMER PREFERENCES: NORTH AMERICA (NA)
-- Objective: Which genres dominate North America, and what market and economic forces shape the ranking?
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(na_sales) AS north_america_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    north_america_sales DESC;

-- ------------------------------------------------------------------------------
-- 7. QUALITY VS. COMMERCIAL SUCCESS
-- Objective: Which games earned the highest critic scores, and what design choices explain their acclaim beyond sales?
-- ------------------------------------------------------------------------------
SELECT 
    title,
    critic_score,
    total_sales
FROM 
    games
WHERE 
    critic_score IS NOT NULL
ORDER BY 
    critic_score DESC
LIMIT 20;
-- ==============================================================================
-- PROJECT: Global Video Game Market Analysis (1980-2020)
-- CORE ANALYTICAL QUERIES (MySQL)
-- Developer: Christopher Blanco
-- ==============================================================================
-- ==============================================================================
-- SECTION 1: MARKET VOLUME & CATALOG EXPLORATION (NEW INSIGHTS)
-- Objective: Analyze production volume, market presence, and developer activity.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- A. TOP 10 PUBLISHERS BY TOTAL TITLES RELEASED
-- Objective: Identify which companies have the largest catalog footprint in the dataset.
-- ------------------------------------------------------------------------------
SELECT 
    publisher, 
    COUNT(title) AS total_games
FROM 
    games
GROUP BY 
    publisher
ORDER BY 
    total_games DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- B. TOP 10 DEVELOPERS BY TOTAL GLOBAL SALES
-- Objective: Measure financial success at the developer level rather than the publisher level.
-- ------------------------------------------------------------------------------
SELECT 
    developer,
    SUM(total_sales) AS total_sales
FROM 
    games
WHERE 
    developer IS NOT NULL
GROUP BY 
    developer
ORDER BY 
    total_sales DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- C. TOTAL TITLES RELEASED BY CONSOLE
-- Objective: Understand platform lifecycle density by counting historical game releases.
-- ------------------------------------------------------------------------------
SELECT 
    console,
    COUNT(title) AS total_games
FROM 
    games
GROUP BY 
    console
ORDER BY 
    total_games DESC;

-- ------------------------------------------------------------------------------
-- D. TOP 20 PUBLISHER-GENRE COMBINATIONS BY VOLUME
-- Objective: Discover specific market specializations (e.g., EA Sports in Sports).
-- ------------------------------------------------------------------------------
SELECT 
    publisher, 
    genre, 
    COUNT(title) AS total_games
FROM 
    games
GROUP BY 
    publisher, 
    genre
ORDER BY 
    total_games DESC
LIMIT 20;


-- ==============================================================================
-- SECTION 2: CORE BUSINESS & PERFORMANCE REPORTING
-- Objective: Strategic queries mapped directly to the main dashboard report.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. GLOBAL SALES ANALYSIS BY GENRE
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    total_sales DESC;

-- ------------------------------------------------------------------------------
-- 2. TOP 10 PUBLISHERS BY GLOBAL SALES (UNITS SOLD)
-- ------------------------------------------------------------------------------
SELECT 
    publisher, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    publisher
ORDER BY 
    total_sales DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- 3. ANALYSIS OF GLOBAL SOFTWARE SALES BY CONSOLE
-- ------------------------------------------------------------------------------
SELECT 
    console, 
    SUM(total_sales) AS total_sales
FROM 
    games
GROUP BY 
    console
ORDER BY 
    total_sales DESC;

-- ------------------------------------------------------------------------------
-- 4. TOP 10 BEST-SELLING VIDEO GAMES (BY PLATFORM)
-- ------------------------------------------------------------------------------
SELECT 
    title,
    console,
    total_sales
FROM 
    games
ORDER BY 
    total_sales DESC
LIMIT 10;

-- ------------------------------------------------------------------------------
-- 5. CONSUMER PREFERENCES: JAPAN (JP)
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(jp_sales) AS japan_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    japan_sales DESC;

-- ------------------------------------------------------------------------------
-- 6. CONSUMER PREFERENCES: NORTH AMERICA (NA)
-- ------------------------------------------------------------------------------
SELECT 
    genre, 
    SUM(na_sales) AS north_america_sales
FROM 
    games
GROUP BY 
    genre
ORDER BY 
    north_america_sales DESC;

-- ------------------------------------------------------------------------------
-- 7. QUALITY VS. COMMERCIAL SUCCESS
-- ------------------------------------------------------------------------------
SELECT 
    title,
    critic_score,
    total_sales
FROM 
    games
WHERE 
    critic_score IS NOT NULL
ORDER BY 
    critic_score DESC
LIMIT 20;
