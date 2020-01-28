Explore-libraries
================
Andy
2020-01-27

Which libraries does R search for packages?

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────── tidyverse 1.3.0 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.3
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   1.0.0     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
# try .libPaths(), .Library
.libPaths()
```

    ## [1] "/Library/Frameworks/R.framework/Versions/3.6/Resources/library"

``` r
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

Installed packages

``` r
## use installed.packages() to get all installed packages
## if you like working with data frame or tibble, make it so right away!
## remember to use View(), dplyr::glimpse(), or similar to inspect

## how many packages?
dat <- as.data.frame(installed.packages())
View(dat)
nrow(dat)
```

    ## [1] 467

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
dat %>% count(.$Priority)
```

    ## Warning: Factor `.$Priority` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 2
    ##   `.$Priority`     n
    ##   <fct>        <int>
    ## 1 base            14
    ## 2 recommended     15
    ## 3 <NA>           438

``` r
dat %>% count(Priority) # These both do the same. One tidyverse compliant, one not so much.
```

    ## Warning: Factor `Priority` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 2
    ##   Priority        n
    ##   <fct>       <int>
    ## 1 base           14
    ## 2 recommended    15
    ## 3 <NA>          438

``` r
dat %>% count(.$LibPath)
```

    ## # A tibble: 1 x 2
    ##   `.$LibPath`                                                        n
    ##   <fct>                                                          <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.6/Resources/library   467

``` r
dat %>% count(.$Priority, .$LibPath)
```

    ## Warning: Factor `.$Priority` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 3
    ##   `.$Priority` `.$LibPath`                                                     n
    ##   <fct>        <fct>                                                       <int>
    ## 1 base         /Library/Frameworks/R.framework/Versions/3.6/Resources/lib…    14
    ## 2 recommended  /Library/Frameworks/R.framework/Versions/3.6/Resources/lib…    15
    ## 3 <NA>         /Library/Frameworks/R.framework/Versions/3.6/Resources/lib…   438

``` r
##   * what proportion need compilation?
#NCY <- dat %>% filter(NeedsCompilation == "yes") %>% nrow()
#percent(NCY / nrow(dat))

#Should have used this: 
dat %>% count(.$NeedsCompilation) %>% mutate(prop = n / sum(n))
```

    ## Warning: Factor `.$NeedsCompilation` contains implicit NA, consider using
    ## `forcats::fct_explicit_na`

    ## # A tibble: 3 x 3
    ##   `.$NeedsCompilation`     n   prop
    ##   <fct>                <int>  <dbl>
    ## 1 no                     245 0.525 
    ## 2 yes                    207 0.443 
    ## 3 <NA>                    15 0.0321

``` r
##   * how break down re: version of R they were built on
dat %>% count(.$Built)
```

    ## # A tibble: 2 x 2
    ##   `.$Built`     n
    ##   <fct>     <int>
    ## 1 3.6.0       438
    ## 2 3.6.2        29

``` r
## for tidyverts, here are some useful patterns
# data %>% count(var)
# data %>% count(var1, var2)
# data %>% count(var) %>% mutate(prop = n / sum(n))
```

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?

# Yes, this is what we stated in the slides- This is the amount of base and recommended in each install.

##   * how does the result of .libPaths() relate to the result of .Library?
# These do not go to the same place--one is a bit higher order than the other.
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
# I don't think any packages are in .Library...

## study package naming style (all lower case, contains '.', etc)


## use `fields` argument to installed.packages() to get more info and use it!
```
