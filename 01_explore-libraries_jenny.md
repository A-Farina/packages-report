01\_explore-libraries\_jenny.R
================
Andy
2020-01-27

``` r
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for
    packages?

``` r
.libPaths()
```

    ## [1] "/Library/Frameworks/R.framework/Versions/3.6/Resources/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

``` r
identical(.Library, .libPaths()[2])
```

    ## [1] FALSE

``` r
## Huh? Maybe this is an symbolic link issue?
library(fs)
identical(path_real(.Library), path_real(.libPaths()[2]))
```

    ## [1] FALSE

Installed packages

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
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 467

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 3 x 3
    ##   LibPath                                                       Priority       n
    ##   <chr>                                                         <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.6/Resources/libra… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.6/Resources/libra… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.6/Resources/libra… <NA>         438

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                 245 0.525 
    ## 2 yes                207 0.443 
    ## 3 <NA>                15 0.0321

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   Built     n   prop
    ##   <chr> <int>  <dbl>
    ## 1 3.6.0   438 0.938 
    ## 2 3.6.2    29 0.0621

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##   [1] "abind"                 "academicWriteR"        "acepack"              
    ##   [4] "apaTables"             "arm"                   "arules"               
    ##   [7] "askpass"               "assertthat"            "available"            
    ##  [10] "backports"             "base64enc"             "bayesplot"            
    ##  [13] "bayestestR"            "BDgraph"               "BH"                   
    ##  [16] "bibtex"                "bit"                   "bit64"                
    ##  [19] "bitops"                "blob"                  "blogdown"             
    ##  [22] "blotter"               "bookdown"              "brew"                 
    ##  [25] "broom"                 "broom.mixed"           "callr"                
    ##  [28] "car"                   "carData"               "caret"                
    ##  [31] "caretEnsemble"         "caTools"               "cellranger"           
    ##  [34] "checkmate"             "citr"                  "classInt"             
    ##  [37] "cli"                   "clinfun"               "clipr"                
    ##  [40] "clisymbols"            "coda"                  "colorspace"           
    ##  [43] "colourpicker"          "commonmark"            "compute.es"           
    ##  [46] "corpcor"               "covr"                  "cowplot"              
    ##  [49] "crayon"                "crosstalk"             "curl"                 
    ##  [52] "cvTools"               "d3Network"             "data.table"           
    ##  [55] "DataExplorer"          "DBI"                   "dbplyr"               
    ##  [58] "deldir"                "dendextend"            "denpro"               
    ##  [61] "DEoptimR"              "desc"                  "DescTools"            
    ##  [64] "devtools"              "dials"                 "DiceDesign"           
    ##  [67] "digest"                "diptest"               "doMC"                 
    ##  [70] "doParallel"            "dplyr"                 "dslabs"               
    ##  [73] "DT"                    "dtplyr"                "dygraphs"             
    ##  [76] "e1071"                 "effsize"               "elasticnet"           
    ##  [79] "ellipse"               "ellipsis"              "emmeans"              
    ##  [82] "energy"                "estimability"          "evaluate"             
    ##  [85] "exactRankTests"        "expm"                  "expss"                
    ##  [88] "ez"                    "factoextra"            "FactoMineR"           
    ##  [91] "fansi"                 "farina"                "farver"               
    ##  [94] "fastmap"               "fdrtool"               "finalfit"             
    ##  [97] "FinancialInstrument"   "flashClust"            "flexmix"              
    ## [100] "flextable"             "forcats"               "foreach"              
    ## [103] "Formula"               "fpc"                   "fs"                   
    ## [106] "furrr"                 "future"                "gapminder"            
    ## [109] "gdata"                 "gdtools"               "generics"             
    ## [112] "GGally"                "ggforce"               "ggm"                  
    ## [115] "ggplot2"               "ggpubr"                "ggraph"               
    ## [118] "ggrepel"               "ggridges"              "ggsci"                
    ## [121] "ggsignif"              "ggthemes"              "ggvis"                
    ## [124] "gh"                    "git2r"                 "glasso"               
    ## [127] "glmnet"                "globals"               "glue"                 
    ## [130] "gmodels"               "goftest"               "gower"                
    ## [133] "GPArotation"           "graphlayouts"          "gridExtra"            
    ## [136] "gsubfn"                "gtable"                "gtools"               
    ## [139] "haven"                 "here"                  "highr"                
    ## [142] "HistData"              "Hmisc"                 "hms"                  
    ## [145] "htmlTable"             "htmltools"             "htmlwidgets"          
    ## [148] "httpuv"                "httr"                  "huge"                 
    ## [151] "hunspell"              "igraph"                "infer"                
    ## [154] "ini"                   "inline"                "insight"              
    ## [157] "ipred"                 "irlba"                 "ISOcodes"             
    ## [160] "iterators"             "janeaustenr"           "jomo"                 
    ## [163] "jpeg"                  "jsonlite"              "kableExtra"           
    ## [166] "kernlab"               "km.ci"                 "KMsurv"               
    ## [169] "knitr"                 "kutils"                "labeling"             
    ## [172] "laeken"                "Lahman"                "lars"                 
    ## [175] "later"                 "latticeExtra"          "lava"                 
    ## [178] "lavaan"                "lazyeval"              "leaps"                
    ## [181] "LearnBayes"            "lifecycle"             "lisrelToR"            
    ## [184] "listenv"               "lme4"                  "lmtest"               
    ## [187] "loo"                   "lubridate"             "magick"               
    ## [190] "magrittr"              "manipulate"            "maptools"             
    ## [193] "markdown"              "matrixcalc"            "MatrixModels"         
    ## [196] "matrixStats"           "maxstat"               "MBESS"                
    ## [199] "mc2d"                  "mclust"                "memoise"              
    ## [202] "mi"                    "mice"                  "mime"                 
    ## [205] "miniUI"                "minqa"                 "MissMech"             
    ## [208] "mitml"                 "mix"                   "mlbench"              
    ## [211] "mnormt"                "ModelMetrics"          "modelr"               
    ## [214] "modeltools"            "moments"               "MplusAutomation"      
    ## [217] "multcomp"              "munsell"               "MVN"                  
    ## [220] "mvoutlier"             "mvtnorm"               "NADA"                 
    ## [223] "naniar"                "networkD3"             "nloptr"               
    ## [226] "nortest"               "numDeriv"              "odbc"                 
    ## [229] "officer"               "olsrr"                 "OpenMx"               
    ## [232] "openssl"               "openxlsx"              "ordinal"              
    ## [235] "packrat"               "pacman"                "pan"                  
    ## [238] "pander"                "papaja"                "parsedate"            
    ## [241] "parsnip"               "pastecs"               "pbapply"              
    ## [244] "pbivnorm"              "pbkrtest"              "pcaPP"                
    ## [247] "pdftools"              "PerformanceAnalytics"  "pgirmess"             
    ## [250] "pillar"                "pkgbuild"              "pkgconfig"            
    ## [253] "pkgload"               "pkgsearch"             "plogr"                
    ## [256] "pls"                   "plyr"                  "png"                  
    ## [259] "poLCA"                 "polyclip"              "polynom"              
    ## [262] "prabclus"              "praise"                "prettyunits"          
    ## [265] "pROC"                  "processx"              "prodlim"              
    ## [268] "progress"              "promises"              "proto"                
    ## [271] "proxy"                 "pryr"                  "ps"                   
    ## [274] "psy"                   "psych"                 "purrr"                
    ## [277] "pwr"                   "qgraph"                "qpdf"                 
    ## [280] "qqplotr"               "quadprog"              "quantmod"             
    ## [283] "QuantPsyc"             "quantreg"              "quantstrat"           
    ## [286] "R6"                    "randomForest"          "randomForestExplainer"
    ## [289] "ranger"                "RANN"                  "rapportools"          
    ## [292] "raster"                "rattle"                "rcmdcheck"            
    ## [295] "RColorBrewer"          "Rcpp"                  "RcppArmadillo"        
    ## [298] "RcppEigen"             "RcppProgress"          "RcppRoll"             
    ## [301] "RCurl"                 "readr"                 "readxl"               
    ## [304] "recipes"               "recommenderlab"        "recosystem"           
    ## [307] "RefManageR"            "reghelper"             "registry"             
    ## [310] "regpro"                "regsem"                "rematch"              
    ## [313] "rematch2"              "remotes"               "repr"                 
    ## [316] "reprex"                "reshape"               "reshape2"             
    ## [319] "reticulate"            "rex"                   "rgdal"                
    ## [322] "rgeos"                 "rio"                   "rjson"                
    ## [325] "rlang"                 "rmarkdown"             "robCompositions"      
    ## [328] "robustbase"            "rockchalk"             "roxygen2"             
    ## [331] "rpart.plot"            "rpf"                   "rprojroot"            
    ## [334] "rqPen"                 "rrcov"                 "rsample"              
    ## [337] "rsconnect"             "RSNNS"                 "Rsolnp"               
    ## [340] "RSQLite"               "rstan"                 "rstanarm"             
    ## [343] "rstantools"            "rstudioapi"            "rticles"              
    ## [346] "RUnit"                 "rversions"             "rvest"                
    ## [349] "sandwich"              "scales"                "scatterplot3d"        
    ## [352] "selectr"               "sem"                   "semPlot"              
    ## [355] "semTools"              "servr"                 "sessioninfo"          
    ## [358] "sf"                    "sgeostat"              "shape"                
    ## [361] "shiny"                 "shinyjs"               "shinystan"            
    ## [364] "shinythemes"           "sjlabelled"            "sjmisc"               
    ## [367] "skimr"                 "SnowballC"             "sourcetools"          
    ## [370] "sp"                    "SparseM"               "spData"               
    ## [373] "spdep"                 "splancs"               "splitChunk"           
    ## [376] "SQUAREM"               "sROC"                  "StanHeaders"          
    ## [379] "stopwords"             "stringdist"            "stringi"              
    ## [382] "stringr"               "summarytools"          "survminer"            
    ## [385] "survMisc"              "sys"                   "systemfonts"          
    ## [388] "testthat"              "texreg"                "TH.data"              
    ## [391] "threejs"               "tibble"                "tidygraph"            
    ## [394] "tidymodels"            "tidyposterior"         "tidypredict"          
    ## [397] "tidyr"                 "tidyselect"            "tidytext"             
    ## [400] "tidyverse"             "timeDate"              "tinytex"              
    ## [403] "TMB"                   "tokenizers"            "translations"         
    ## [406] "truncnorm"             "TTR"                   "tweenr"               
    ## [409] "ucminf"                "udapi"                 "units"                
    ## [412] "UpSetR"                "usethis"               "utf8"                 
    ## [415] "uuid"                  "varhandle"             "vcd"                  
    ## [418] "vctrs"                 "VIM"                   "viridis"              
    ## [421] "viridisLite"           "visdat"                "webshot"              
    ## [424] "whisker"               "withr"                 "WRS2"                 
    ## [427] "xfun"                  "XML"                   "xml2"                 
    ## [430] "xopen"                 "xtable"                "xts"                  
    ## [433] "yaml"                  "yardstick"             "yesno"                
    ## [436] "zCompositions"         "zeallot"               "zip"                  
    ## [439] "zoo"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 FALSE    223 0.478
    ## 2 TRUE     244 0.522
