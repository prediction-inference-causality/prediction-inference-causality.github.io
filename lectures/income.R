income = function(state.codes) {
## Pull Data From Census API
# for cps variable interpretation see https://www2.census.gov/programs-surveys/cps/datasets/2022/march/asec2022_ddl_pub_full.pdf

library(tidyverse)
library(cpsR)
census.api.key = '8084f81e4f71e4d32638dac15f188b424f72d063'

cps.data = cpsR::get_asec(year=2022, 
    vars=c('pearnval', 
          'gestfips', 
          'a_age', 
          'prdtrace',
          'a_hga',
          'gereg', 
          'a_maritl', 
          'a_sex',
          'peafever',
          'a_wkstat',
          'gtco'), key=census.api.key)

## Process Data

all.earnings = data.frame(age=cps.data$a_age,
                          state.code = cps.data$gestfips,
                          county.code = cps.data$gtco,
                          income=cps.data$pearnval, 
                          sex=case_match(cps.data$a_sex,
                            1 ~ 'male',
                            2 ~ 'female'),
                          education=case_match(cps.data$a_hga,
                                          0  ~ 0,   # child
                                          31 ~ 0,   # < grade 1
                                          32 ~ 4,   #  grade 1-4
                                          33 ~ 6,   #  grade 5-6
                                          34 ~ 8,   #  grade 7-8 
                                          35 ~ 9,   #  grade 9
                                          36 ~ 10,  #  grade 10
                                          37 ~ 11,  #  grade 11
                                          38 ~ 11,  #  grade 12 no diploma
                                          39 ~ 12,  #  high school grad
                                          40 ~ 13,  #  some college
                                          41 ~ 14,  #  associate degree(vocational)
                                          42 ~ 14,  #  associate degree (academic)
                                          43 ~ 16,  #  bachelors degree
                                          44 ~ 18,  #  masters degree
                                          45 ~ 20,  #  professional school degree
                                          46 ~ 20), #  doctorate
                          race=case_match(cps.data$prdtrace,
                                           01  ~ "White only",
                                           02  ~ "Black only",
                                           03  ~ "American Indian, Alaskan Native only (AI)",
                                           04  ~ "Asian only",
                                           05  ~ "Hawaiian/Pacific Islander only (HP)",
                                           06  ~ "White-Black",
                                           07  ~ "White-AI",
                                           08  ~ "White-Asian",
                                           09  ~ "White-HP",
                                           10  ~ "Black-AI",
                                           11  ~ "Black-Asian",
                                           12  ~ "Black-HP",
                                           13  ~ "AI-Asian",
                                           14  ~ "AI-HP",
                                           15  ~ "Asian-HP",
                                           16  ~ "White-Black-AI",
                                           17  ~ "White-Black-Asian",
                                           18  ~ "White-Black-HP",
                                           19  ~ "White-AI-Asian",
                                           20  ~ "White-AI-HP",
                                           21  ~ "White-Asian-HP",
                                           22  ~ "Black-AI-Asian",
                                           23  ~ "White-Black-AI-Asian",
                                           24  ~ "White-AI-Asian-HP",
                                           25  ~ "Other 3 race comb.",
                                           26  ~ "Other 4 or 5 race comb"))

in.interval = function(X, interval) { interval[1] <= X & X <= interval[2] }
all.earnings$employed<- ifelse(cps.data$a_wkstat >5, 0,ifelse(cps.data$a_wkstat<2,NA,1))
all.earnings$degree = factor(all.earnings$education >= 16,
                    levels=c(0, 1), 
                    labels=c('no 4-year degree','4-year degree')) 
all.earnings$sex = factor(all.earnings$sex, 
                          levels=c('female', 'male'))
all.earnings$race = factor(all.earnings$race)
rownames(all.earnings)==NULL
earnings = all.earnings[all.earnings$age %>% in.interval(c(25,35)) & 
                        all.earnings$state.code %in% state.codes & 
            all.earnings$education >= 8, ]

# This is cheating a bit, but I'm going to get rid of one very inconvenient millionaire
# who blows up our estimated variance for income among those with 11 years of education.
earnings = earnings[earnings$income < 1e6 | earnings$education >= 12, ]

rownames(earnings)=NULL
earnings$person = 1:nrow(earnings)

## That's the end of it if we're not looking at California.
california.state.code = 6
if(!identical(state.codes, california.state.code)) return(list(sample=earnings, info=NULL))
  
## California is the state we introduce first, so we'll add some information in tht case to make the survey feel a bit more real.
#  We'll give each person a physical location, so we can plot them on a map. 
#  This location will be a point chosen randomly within --- or almost within --- the county they live in.
#  We have that county in the census data and we can get the county location and shape from the maps package.

# To start, we'll translate the county codes in the census data to actual county names
# and while we're at it, take down some information about those counties.
# The county info is from https://en.wikipedia.org/wiki/List_of_counties_in_California
# and has been converted to csv using https://wikitable2csv.ggor.de
to.number = function(s) { as.numeric(str_trim(gsub(",", "", s))) }
ca_county_info = read.csv('data/california_county_info.csv') %>%
  mutate(subregion = tolower(sub(' County', '', County))) %>%
  mutate(pop = to.number(Population..2022.)) %>%
  mutate(area = to.number(sub('sq.*', '', Area))) 

earnings.county = left_join(earnings, ca_county_info[,c('FIPS.code', 'subregion')], by=c('county.code' = 'FIPS.code'))
earnings$county = earnings.county$subregion
earnings$county[is.na(earnings$county)]='unknown'

# Now we'll get the actual county shapes and add their centers to our county info 
# Or sort of their centers. We'll take the average of the lat/long of the vertices of the county shape.
counties = map_data("county")
ca_county = counties %>%
  filter(region == "california")
ca_county_centers = ca_county %>%
  group_by(subregion) %>%
  summarize(county.lat = mean(lat), county.long=mean(long))

ca_county_more = left_join(ca_county_centers, ca_county_info, by="subregion")
ca_all = left_join(ca_county, ca_county_more, by="subregion")

# Now we'll sample points within the counties for each person in our sample.
# This function takes a list of subregions, possibly with duplicates
# for each element, chooses random lat/long coordinates within the sample.subregion
# by taking a random convex combination of the subregion's vertices
## Some people live in 'unknown' counties. We'll assign them a location by 
# acting as if county info were missing at random, i.e., as if they live in 
# a random county drawn from the distribution of counties in the sample that aren't 'unknown'

## To make this random sampling deterministic without messing with the current seed, we'll use this function. 
with_seed = function(thunk, seed) {
    if(!exists('.Random.seed')) RNGkind('Mersenne-Twister')
    current.seed = .Random.seed
    set.seed(seed)
    result = thunk()
    set.seed(current.seed)
    result
}

sample.within.subregion = function(subregions, seed=1) {
  subregions[subregions=='unknown'] = (\() sample(subregions[subregions!='unknown'], 
                                                 sum(subregions=='unknown'), 
                                                 replace=TRUE)) |> with_seed(seed)
  output = data.frame(subregion=subregions, lat=NA, long=NA)
  for(subregion in unique(subregions)) { 
      vertices = ca_county[ca_county$subregion==subregion, c('lat','long')]
      U = sum(subregions==subregion)
      V = nrow(vertices)
      weights = abs(rt(U*V, 1))
      dim(weights) = c(U,V)
      weights = (1/rowSums(weights)) * weights
      output[subregions==subregion, c('lat', 'long')] = 
                 cbind(weights %*% vertices$lat, weights %*% vertices$long)
    }
    output
}

subregions = earnings$county
locations = sample.within.subregion(subregions)
list(sample = cbind(earnings, locations),
     info = ca_all,
     sample_location=sample.within.subregion)
}
