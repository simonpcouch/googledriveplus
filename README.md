
## An Extension of `googledrive` for the Reed College mLab

This is a quick extension to Jenny Bryan’s `googledrive` package to
allow for grabbing data from Google Drive and returning it as an R
object without saving the object to the user’s local file system. This
is meant to allow for several people to work with the same data without
having to deal with downloading files, changing filepaths, and `getwd()`
fussiness.

This code can be used to load the package:

``` r
library(devtools)
install_github("simonpcouch/googledriveplus")
library(googledriveplus)
```

The new function, `grab_data`, can be used like
this:

``` r
grab_data(url = "https://drive.google.com/open?id=1JnkQddF8FmY0YsXZSWBanQNPjZ_LBIQUGi_s43vNDIQ",
          filetype = "Sheet")
```


    ## # A tibble: 14 x 2
    ##    compelling_narrative index
    ##    <chr>                <dbl>
    ##  1 hi                       1
    ##  2 this                     2
    ##  3 is                       3
    ##  4 a                        4
    ##  5 test                     5
    ##  6 file                     6
    ##  7 to                       7
    ##  8 see                      8
    ##  9 how                      9
    ## 10 slick                   10
    ## 11 this                    11
    ## 12 googledrive             12
    ## 13 workflow                13
    ## 14 is                      14

There is *a lot* of `googledrive` (and other `tidyverse`) functionality
lost when using this function—this should only be used for basic table
loading.

Simon Couch
