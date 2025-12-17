
source("src/00_libs.R")

data <- read_excel(
  "data/jiec70074-sup-0003-suppmat.xlsx",
  sheet = "Fig. 3f"
  ) |>
  rename(
    value = `t CO2eq/cap`,
    name = product_group,
    Quantile = deciles
  ) |>
  mutate(
    value = round(value * 1000),
    Quantile = case_when(
      Quantile == 1 ~ "Arme",
      Quantile == 3 ~ "Untere Mittelschicht",
      Quantile == 5 ~ "Mittelschicht",
      Quantile == 7 ~ "Obere Mittelschicht",
      Quantile == 10 ~ "Reiche",
      TRUE ~ as.character(Quantile)
    )
  ) |>
  mutate(
    name = case_when(
      name == "Food and beverages" ~ "Lebensmittel",
      name == "Housing and energy" ~ "Wohnen",
      name == "Housing and energy, direct" ~ "Wohnen",
      name == "Mobility" ~ "Mobilität",
      name == "Mobility, direct" ~ "Mobilität",
      name == "Goods like clothing or household equipment" ~ "Güter",
      name == "Services (accomodation, restaurants, health, recreation, etc.)" ~ "Dienstleistungen",
      TRUE ~ name
    )
  ) |>
  group_by(name, Quantile) |>
  summarize(value = sum(value)) |>
  filter(nchar(Quantile) > 1) |>
  ungroup()

data_agg <- data |>
  group_by(Quantile) |>
  summarize(value = sum(value)) |>
  mutate(name = "Emissionen Gesamt") |>
  ungroup()

add_row(data, data_agg) |>
  write_csv("data/data.csv")