zar_dat <- read_excel("data-102742-2021-08-04.xlsx")

glimpse(zar_dat)
dfSummary(zar_dat)

table_zone <- zar_dat %>% tabyl(., LandscapingZone)
table_place <- zar_dat %>% tabyl(., LocationPlace)

m_name_rus <- c("январь", "февраль", "март", "апрель", "май", "июнь",
                "июль", "август", "сентябрь", "октябрь", "ноябрь", "декабрь")

zar_dat_clean <- zar_dat %>%
  mutate(ProsperityPeriod = str_squish(tolower(ProsperityPeriod)),
         BloomStart = sub(" -.*", "", ProsperityPeriod),
         BloomEnd = sub(".*- ", "", ProsperityPeriod)) %>%
  mutate_at(vars(BloomStart, BloomEnd), match, m_name_rus) %>%
  mutate_at(vars(BloomStart, BloomEnd), as.numeric) %>%
  mutate_at(vars(BloomStart, BloomEnd), replace_na, 0) %>%
  rowwise() %>%
  do(data.frame(.[1:10], `Month` = seq(.$BloomStart, .$BloomEnd))) %>%
  ungroup()

ggplot(zar_dat_clean, aes(x = Month, y = LandscapingZone, fill = LandscapingZone)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")

test <- zar_dat_clean %>%
  group_by(LandscapingZone, Month) %>%
  summarize(Count = length(Name)) %>%
  ungroup()

ggplot(diamonds, aes(x = price, y = cut, fill = cut)) +
  geom_density_ridges() +
  theme_ridges() + 
  theme(legend.position = "none")
