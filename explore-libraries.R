#' ---
#' title: "Explore-libraries"
#' output: 
#'    html_document:
#'    keep_md = TRUE
#' ---

#' Which libraries does R search for packages?
library(tidyverse)
# try .libPaths(), .Library
.libPaths()
.Library
#' Installed packages

## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

## how many packages?
dat <- as.data.frame(installed.packages())
View(dat)
nrow(dat)

#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
dat %>% count(.$Priority)
dat %>% count(Priority) # These both do the same. One tidyverse compliant, one not so much.
dat %>% count(.$LibPath)
dat %>% count(.$Priority, .$LibPath)

##   * what proportion need compilation?
#NCY <- dat %>% filter(NeedsCompilation == "yes") %>% nrow()
#percent(NCY / nrow(dat))

#Should have used this: 
dat %>% count(.$NeedsCompilation) %>% mutate(prop = n / sum(n))

##   * how break down re: version of R they were built on
dat %>% count(.$Built)

## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?

# Yes, this is what we stated in the slides- This is the amount of base and recommended in each install.

##   * how does the result of .libPaths() relate to the result of .Library?
# These do not go to the same place--one is a bit higher order than the other.

#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
# I don't think any packages are in .Library...

## study package naming style (all lower case, contains '.', etc)


## use `fields` argument to installed.packages() to get more info and use it!