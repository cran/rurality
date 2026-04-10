## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(rurality)
library(dplyr)

## -----------------------------------------------------------------------------
get_rurality("05031")

## -----------------------------------------------------------------------------
rurality_score("05031")
get_rucc("05031")

## -----------------------------------------------------------------------------
rurality_score(c("05031", "06037", "48453"))

## -----------------------------------------------------------------------------
get_ruca("72401")
get_ruca(c("72401", "90210", "59801"))

## -----------------------------------------------------------------------------
my_data <- data.frame(
  fips = c("05031", "06037", "48453", "30063"),
  outcome = c(0.72, 0.41, 0.58, 0.89)
)

my_data |> add_rurality()

## -----------------------------------------------------------------------------
my_data |> add_rurality(vars = "all") |> glimpse()

## -----------------------------------------------------------------------------
other_data <- data.frame(county_fips = c("05031", "06037"), y = 1:2)
other_data |> add_rurality(fips_col = "county_fips")

## -----------------------------------------------------------------------------
classify_rurality(c(10, 30, 50, 70, 90))

## -----------------------------------------------------------------------------
county_rurality

## -----------------------------------------------------------------------------
county_rurality |>
  filter(state_abbr == "AR") |>
  select(county_name, rurality_score, rurality_classification, rucc_2023) |>
  arrange(desc(rurality_score)) |>
  head(10)

## ----fig.width=6, fig.height=4------------------------------------------------
if (requireNamespace("ggplot2", quietly = TRUE)) {
  ggplot2::ggplot(county_rurality, ggplot2::aes(x = rurality_score)) +
    ggplot2::geom_histogram(binwidth = 5, fill = "#15803d", color = "white") +
    ggplot2::labs(
      title = "Distribution of Rurality Scores Across U.S. Counties",
      x = "Rurality Score (0-100)",
      y = "Number of Counties"
    ) +
    ggplot2::theme_minimal()
}

## -----------------------------------------------------------------------------
citation("rurality")

