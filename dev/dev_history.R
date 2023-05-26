#dev_history.R
usethis::create_tidy_package(path = "~/shiny.dsfr")
dir.create("dev/")

# ignore build directory
usethis::use_build_ignore("dev/")
usethis::use_build_ignore("docs")
usethis::use_build_ignore(".gitlab-ci.yml")

usethis::use_git()

# charpente::create_dependency("@gouvfr/dsfr") NE FONCTIONNE

# charpente::create_dependency("bulma") DONNE LA STRUCTURE

usethis::use_test("first_check")
usethis::use_pipe()

usethis::use_r("dsfr-page")
usethis::use_r("dsfr-header")
usethis::use_r("utils")
usethis::use_r("dsfr-footer")
usethis::use_r("dsfr-sidebarlayout")
usethis::use_r("dsfr-mainpanel")
usethis::use_r("dsfr-sidebarpanel")
usethis::use_r("dsfr-row")
usethis::use_r("dsfr-col")

usethis::use_r("dsfr-tabsetpanel")
usethis::use_r("dsfr-tabpanel")

usethis::use_r("dsfr-navsidebarpanel")

usethis::use_r("global.R")
usethis::use_r("dsf-widget")


#vignettes
usethis::use_vignette("dev", name = "Dev")
usethis::use_vignette("dsfr_01_header")
usethis::use_vignette("Pied de page (footer)", name = "dsfr_02_footer")

usethis::use_vignette("dsfr_05_tabsetpanel")


# charpente to set up environment
charpente:::set_esbuild()
usethis::use_build_ignore("nodes_modules")
usethis::edit_git_ignore()

# add custom js
charpente::create_js("navesidebar")
charpente::create_js("utils")


# bundle js
charpente::build_js()

# pkgdown to build documentation
usethis::use_build_ignore("pkgdown/")
usethis::use_build_ignore("_pkgdown.yml")
# handle asset
pkgdown::init_site()
pkgdown::build_site()


attachment::att_amend_desc()
devtools::load_all()
