
source("src/00_libs.R")

read_excel("data/emissions-data.xlsx") |>
  pivot_longer(2:11) |>
  mutate(
    value = round(value),
    # nIso = round(value/1000)
    ) |>
  filter(
    name %in% c(
      "Food",
      "Housing",
      "Energy",
      "Mobility",
      "Goods",
      "Services"
    )
  ) |>
  mutate(
    name = case_when(
      name == "Food" ~ "Lebensmittel",
      name == "Housing" ~ "Wohnen",
      name == "Energy" ~ "Energie",
      name == "Mobility" ~ "Mobilität",
      name == "Goods" ~ "Güter",
      name == "Services" ~ "Dienstleistungen",
      TRUE ~ name
    )
  ) |>
  filter(
    Quantile %in% c(1, 2, 3, 4, 5)
  ) |>
  mutate(
    Quantile = case_when(
      Quantile == 1 ~ "Arme",
      Quantile == 2 ~ "Untere Mittelschicht",
      Quantile == 3 ~ "Mittelschicht",
      Quantile == 4 ~ "Obere Mittelschicht",
      Quantile == 5 ~ "Reiche",
      TRUE ~ as.character(Quantile)
    )
  ) |>
  write_csv("data/data.csv")