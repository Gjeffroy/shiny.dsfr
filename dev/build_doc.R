Sys.setenv("IGNORE" = TRUE)
pkgdown::init_site()
pkgdown::build_site()
Sys.setenv("IGNORE" = "")
