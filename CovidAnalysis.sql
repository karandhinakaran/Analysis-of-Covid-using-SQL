--Select *
--from CovidAnalysis.dbo.CovidVaccines
--order by 3,4

--Select Location,date,total_cases,new_cases,total_deaths,population
--from CovidAnalysis..Covidvaccines
--order by 1,2

--Total Cases vs total deaths
--odds of dying of covid
Select Location,date,total_cases,total_deaths,cast(total_deaths as float)/cast(total_cases as float)*100 as DeathPercentage
from CovidAnalysis..Covidvaccines
where location like '%states%'
order by 1,2

--Total Cases vs population
--Cyprus had the highest ratio in 2023
Select Location,date,total_cases,total_deaths,population,cast(total_cases as float)/cast(population as float)*100 as DiseaseContactPercentage
from CovidAnalysis..Covidvaccines
order by 6 desc

--Countries with highest infection rate
--use group by and an aggregate function on the column not included in group by.
Select Location,MAX(total_cases) as HighestInfectionRate,population,cast(MAX(total_cases) as float)/cast(population as float)*100 as DiseaseContactPercentage
from CovidAnalysis..Covidvaccines
group by location,population
order by 4 desc

--Countris with highest death count per population
Select Location,cast(MAX(total_deaths) as float)/cast(population as float)*100 as DeathPerPopulation, cast(MAX(total_deaths) as float) as Deaths
from CovidAnalysis..CovidVaccines
group by location,population
order by 2 desc

--Continent wise total deaths
Select continent, SUM(cast(total_deaths as float)) as Deaths
from CovidAnalysis..CovidVaccines
where continent is not null
group by continent
order by 2 desc

--Global numbers
Select sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_deaths,(sum(cast(new_deaths as int))/ sum((new_cases)))*100 as deathPercentage
from CovidAnalysis..CovidVaccines
where continent is not null

Select location,continent, date, population, cast(new_vaccinations as float),sum(cast(new_vaccinations as float)) over (partition by location order by location,date) as RollingpeopleVaccinated
from CovidAnalysis..CovidVaccines
where continent is not null
order by 2











