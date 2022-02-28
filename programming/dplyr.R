library(dplyr)
library(tidyr)
library(ggplot2)

gapminder <- read.csv("https://raw.githubusercontent.com/berkeley-scf/r-bootcamp-2016/master/data/gapminder-FiveYearData.csv", stringsAsFactors = TRUE)
head(gapminder)


mean(gapminder[gapminder$continent == "Africa", "gdpPercap"])
mean(gapminder[gapminder$continent == "Americas", "gdpPercap"])
mean(gapminder[gapminder$continent == "Asia", "gdpPercap"])

##dplyr, df manipulation handling
library(dplyr)

# year_country_gdp <- gapminder[,c("year", "country", "gdpPercap")]
# year_country_gdp <- select(gapminder, year, country, gdpPercap)
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)
head(year_country_gdp)

year_africa_gdp_euro <- gapminder %>%
  filter(continent == "Africa") %>%
  select(year,country,gdpPercap)

# Dataframe Manipulation/dplyr/group_by

gdp_bycontinents <- gapminder %>%
    group_by(continent) %>%
    summarize(mean_gdpPercap = mean(gdpPercap))

head(gdp_bycontinents)


gdp_bycontinents_byyear <- gapminder %>%
  group_by(continent, year) %>%
  summarize(mean_gdpPercap = mean(gdpPercap))
head(gdp_bycontinents_byyear)


gdp_pop_bycontinents_byyear <- gapminder %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop))

head(gdp_pop_bycontinents_byyear)


# Dataframe Manipulation/dplyr/mutate 
# mutate, summarize와 차이점:origianl data frame에서 추가하는 기능


gapminder_with_extra_vars <- gapminder %>%
    group_by(continent, year) %>%
    mutate(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop))
head(gapminder_with_extra_vars)


gdp_pop_bycontinents_byyear <- gapminder %>%
    mutate(gdp_billion = gdpPercap*pop/10^9) %>%
    group_by(continent, year) %>%
    summarize(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop),
              mean_gdp_billion = mean(gdp_billion),
              sd_gdp_billion = sd(gdp_billion))

head(gdp_pop_bycontinents_byyear)



# Dataframe Manipulation/dplyr/arrange

# use the `arrange()` function to organize the rows 
## arrange함수를 이용한 정렬 

gapminder_with_extra_vars <- gapminder %>%
    group_by(continent, year) %>%
    mutate(mean_gdpPercap = mean(gdpPercap),
              sd_gdpPercap = sd(gdpPercap),
              mean_pop = mean(pop),
              sd_pop = sd(pop)) %>%
    arrange(desc(year), continent)  

head(gapminder_with_extra_vars)


# Tidying Data/tidyr
## `tidyr` package: efficiently transform data regardless of original format


# Tidying Data/tidyr/gather
library(tidyr)
gap_wide <- read.csv("https://raw.githubusercontent.com/berkeley-scf/r-bootcamp-2016/master/data/gapminder_wide.csv", stringsAsFactors = FALSE)
head(gap_wide)

## gather함수 이용: wide to long format 
#(긴 column을 새로운 column의 값으로 변경)

gap_long <- gap_wide %>%
  gather(obstype_year, obs_values, 3:38)  ## obstype_year, obs_values column으로 long하게 바꿈

head(gap_wide)
head(gap_long)
head(gap_wide)

# with the starts_with() function
gap_long <- gap_wide %>%
    gather(obstype_year, obs_values, starts_with('pop'),
           starts_with('lifeExp'), starts_with('gdpPercap'))
head(gap_long)
tail(gap_long)



# Tidying Data/tidyr/separate
# separate function : split the character strings into multiple variables:
## 두개의 변수로 나눠서 처리

gap_long_sep <- gap_long %>% 
  separate(obstype_year, into = c('obs_type','year'), sep = "_") %>% 
  mutate(year = as.integer(year))
head(gap_long_sep)



# Tidying Data/tidyr/spread

# spread: long-> wide form으로 바꿈 (gather와 반대기능) 

head(gap_long_sep)

gap_medium <- gap_long_sep %>% 
  spread(obs_type, obs_values) ## obs_type에 해당하는 변수들이 column으로 가고, 그 values들이 값

head(gap_medium)
tail(gap_medium)
tail(gap_long_sep)