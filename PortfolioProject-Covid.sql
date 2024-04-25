SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER by 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER by 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER by 1,2

--Looking at Total Cases vs Total Deaths--

SELECT 
    Location, 
    date, 
    total_cases,
    total_deaths, 
    CASE 
        WHEN TRY_CAST(total_cases AS FLOAT) = 0 THEN 0
        ELSE (TRY_CAST(total_deaths AS FLOAT) / NULLIF(TRY_CAST(total_cases AS FLOAT), 0)) * 100 
    END AS DeathPercentage
FROM 
    PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 
    Location, 
    date;

--Looking at Total Cases vs Total Deaths--
--Shows Likelihood Of Dying If Covid Is Contracted In The States--

SELECT 
    Location, 
    date, 
    total_cases,
    total_deaths, 
    CASE 
        WHEN TRY_CAST(total_cases AS FLOAT) = 0 THEN 0
        ELSE (TRY_CAST(total_deaths AS FLOAT) / NULLIF(TRY_CAST(total_cases AS FLOAT), 0)) * 100 
    END AS DeathPercentage
FROM 
    PortfolioProject..CovidDeaths
	WHERE location like '%states%'
	AND continent is not null
ORDER BY 
    Location, 
    date;

--Looking at Total Cases vs Population--
--Displays The Percentage of Population Contracted Covid in the US--
SELECT 
    Location, 
    date, 
    population,
	total_cases,
    CASE 
        WHEN TRY_CAST(total_cases AS FLOAT) = 0 THEN 0
        ELSE (TRY_CAST(total_cases AS FLOAT) / NULLIF(TRY_CAST(population AS FLOAT), 0)) * 100 
    END AS InfectionRate
FROM 
    PortfolioProject..CovidDeaths
	WHERE location like '%states%'
ORDER BY 
    Location, 
    date;

	--Looking at Total Cases vs Population--
--Displays The Percentage of Population Contracted Covid in the World--
SELECT 
    Location, 
    date, 
    population,
	total_cases,
    CASE 
        WHEN TRY_CAST(total_cases AS FLOAT) = 0 THEN 0
        ELSE (TRY_CAST(total_cases AS FLOAT) / NULLIF(TRY_CAST(population AS FLOAT), 0)) * 100 
   END AS InfectionRate
FROM 
    PortfolioProject..CovidDeaths
	--WHERE location like '%states%'--
ORDER BY 
    Location, 
    date;

--Looking at Countries With the Highest Infection Rate compared to Population--

Select Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS HighestInfectionRate  
FROM PortfolioProject..CovidDeaths 
GROUP BY Location,Population 
ORDER BY HighestInfectionRate desc


--Displaying Countries with Highest Death Count per Population--

Select Location, MAX(cast(total_deaths as INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths 
--Where location like '%states%'
WHERE continent is not null
GROUP BY Location
ORDER BY TotalDeathCount desc

--Broken down by continent--
--This is the query that shows the correct numbers for all the continents (is null)--
Select location, MAX(cast(total_deaths as INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths 
--Where location like '%states%'
WHERE continent is null
GROUP BY location
ORDER BY TotalDeathCount desc

--Broken down by continent with the highest death count per population--
--is not null--
Select location, MAX(cast(total_deaths as INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths 
--Where location like '%states%'
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount desc


--Global Numbers--

Select date, SUM(new_cases)
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
AND new_cases <>0
GROUP BY date
ORDER BY 1,2

Select date, SUM(new_cases), SUM(new_deaths)
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
AND new_cases <>0
GROUP BY date
ORDER BY 1,2

Select date, SUM(new_cases), SUM(new_deaths), SUM(new_deaths)/SUM(New_Cases)*100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
AND new_cases <>0
GROUP BY date
ORDER BY 1,2

Select date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
AND new_cases <>0
GROUP BY date
ORDER BY 1,2

--Total Deaths Across The World--
Select SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
AND new_cases <>0
ORDER BY 1,2


SELECT * 
FROM PortfolioProject..CovidVaccinations

--Joining Coviddeaths table and covidvaccinations table--
--dea short for CovidDeaths table, vac short for CovidVaccinations table--
SELECT * 
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date

--Looking at Total Population vs Vaccinations--
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
	WHERE dea.continent is not null
	ORDER BY 1,2,3


----SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location)
----FROM PortfolioProject..CovidDeaths dea
----JOIN PortfolioProject..CovidVaccinations vac
----	ON dea.location = vac.location
----	AND dea.date = vac.date
----	WHERE dea.continent is not null
----	ORDER BY 1,2,3

----	SELECT 
----    dea.continent, 
----    dea.location, 
----    dea.date, 
----    dea.population, 
----    vac.new_vaccinations, 
----    SUM(vac.new_vaccinations) OVER (PARTITION BY dea.Location ORDER BY dea.date) AS CumulativeVaccinations
----FROM 
----    PortfolioProject..CovidDeaths dea
----JOIN 
----    PortfolioProject..CovidVaccinations vac
----    ON dea.location = vac.location
----    AND dea.date = vac.date
----WHERE 
----    dea.continent IS NOT NULL
----ORDER BY 
----    dea.continent, 
----    dea.location, 
----    dea.date;

--	--SELECT 
--    --dea.continent, 
--    --dea.location, 
--    --dea.date, 
--    --dea.population, 
--    --vac.new_vaccinations, 
--    SUM(CAST(vac.new_vaccinations AS int)) OVER (PARTITION BY dea.Location ORDER BY dea.date) AS CumulativeVaccinations
--FROM 
--    PortfolioProject..CovidDeaths dea
--JOIN 
--    PortfolioProject..CovidVaccinations vac
--    ON dea.location = vac.location
--    AND dea.date = vac.date
--WHERE 
--    dea.continent IS NOT NULL
--ORDER BY 
--    dea.continent, 
--    dea.location, 
--    dea.date;--

--CUMULATIVE VACCINATIONS--
	
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(COALESCE(CAST(vac.new_vaccinations AS bigint), 0)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
FROM 
    PortfolioProject..CovidDeaths dea
JOIN 
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE 
    dea.continent IS NOT NULL
ORDER BY 
    dea.continent, 
    dea.location, 
    dea.date;

--PERCENT VACCINATED--

SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(COALESCE(CAST(vac.new_vaccinations AS bigint), 0)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
(CumulativeVaccinations/population)*100
FROM 
    PortfolioProject..CovidDeaths dea
JOIN 
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE 
    dea.continent IS NOT NULL
ORDER BY 
    dea.continent, 
    dea.location, 
    dea.date;


	--USE CTE--
	
	WITH PopvsVac (continent, location, date, population, new_vaccinations, CumulativeVaccinations)
AS (	
    SELECT 
        dea.continent, 
        dea.location, 
        dea.date, 
        dea.population, 
        vac.new_vaccinations, 
        SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
    FROM 
        PortfolioProject..CovidDeaths dea
    JOIN 
        PortfolioProject..CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE 
        dea.continent IS NOT NULL
)
SELECT 
    *,
    CASE 
        WHEN Population = 0 THEN NULL
        ELSE (CumulativeVaccinations / Population) * 100
    END AS VaccinationRate
FROM 
    PopvsVac;

	--TEMP TABLE--

--	CREATE TABLE #PercentPopulationVaccinated
--	(
--	Continent nvarchar(255),
--	Location nvarchar (255),
--	DATE datetime,
--	Population numeric,
--	New_Vaccinations numeric,
--	CumulativeVaccinations numeric
--	)
--	INSERT INTO #PercentPopulationVaccinated	
--    SELECT 
--        dea.continent, 
--        dea.location, 
--        dea.date, 
--        dea.population, 
--        vac.new_vaccinations, 
--        SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
--    FROM 
--        PortfolioProject..CovidDeaths dea
--    JOIN 
--        PortfolioProject..CovidVaccinations vac
--        ON dea.location = vac.location
--        AND dea.date = vac.date
--    WHERE 
--        dea.continent IS NOT NULL
--)
--SELECT 
--    *,
--    CASE 
--        WHEN Population = 0 THEN NULL
--        ELSE (CumulativeVaccinations / Population) * 100
--    END AS VaccinationRate
--FROM #PercentPopulationVaccinated

--CREATE TABLE #PercentPopulationVaccinated
--(
--    Continent nvarchar(255),
--    Location nvarchar(255),
--    DATE datetime,
--    Population numeric,
--    New_Vaccinations numeric,
--    CumulativeVaccinations numeric
--)

--INSERT INTO #PercentPopulationVaccinated	
--SELECT 
--    dea.continent, 
--    dea.location, 
--    dea.date, 
--    dea.population, 
--    vac.new_vaccinations, 
--    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
--FROM 
--    PortfolioProject..CovidDeaths dea
--JOIN 
--    PortfolioProject..CovidVaccinations vac
--    ON dea.location = vac.location
--    AND dea.date = vac.date
--WHERE 
--    dea.continent IS NOT NULL

--SELECT 
--    *,
--    CASE 
--        WHEN Population = 0 THEN NULL
--        ELSE (CumulativeVaccinations / Population) * 100
--    END AS VaccinationRate
--FROM 
--    #PercentPopulationVaccinated

--	CREATE TABLE #PercentPopulationVaccinated
--(
--    Continent nvarchar(255),
--    Location nvarchar(255),
--    DATE datetime,
--    Population numeric,
--    New_Vaccinations numeric,
--    CumulativeVaccinations numeric
--)

--INSERT INTO #PercentPopulationVaccinated	
--SELECT 
--    dea.continent, 
--    dea.location, 
--    dea.date, 
--    dea.population, 
--    vac.new_vaccinations, 
--    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
--FROM 
--    PortfolioProject..CovidDeaths dea
--JOIN 
--    PortfolioProject..CovidVaccinations vac
--    ON dea.location = vac.location
--    AND dea.date = vac.date
--WHERE 
--    dea.continent IS NOT NULL

--SELECT 
--    *,
--    CASE 
--        WHEN Population = 0 THEN NULL
--        ELSE (CumulativeVaccinations / Population) * 100
--    END AS VaccinationRate
--FROM 
--    #PercentPopulationVaccinated

	
DROP TABLE IF exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
    Continent nvarchar(255),
    Location nvarchar(255),
    DATE datetime,
    Population numeric,
    New_Vaccinations numeric,
    CumulativeVaccinations numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
FROM 
    PortfolioProject..CovidDeaths dea
JOIN 
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (CumulativeVaccinations/Population)*100 AS VaccinationRate
FROM #PercentPopulationVaccinated


--CREATING VIEW TO STORE DATE FOR LATER VISUALIZATIONS--

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations, 
    SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS CumulativeVaccinations
FROM 
    PortfolioProject..CovidDeaths dea
JOIN 
    PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentPopulationVaccinated

























	












