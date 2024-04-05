set.seed(123)
library(dplyr)

years <- 2004:2023
n <- length(years)
data <- data.frame(
  Year = years,
  Hospital1 = sample(100:200, n, replace = TRUE),
  Hospital2 = sample(100:200, n, replace = TRUE),
  Hospital3 = sample(100:200, n, replace = TRUE),
  Hospital4 = sample(100:200, n, replace = TRUE),
  Hospital5 = sample(100:200, n, replace = TRUE)
)


data <- data %>%
  mutate(TotalDeaths = Hospital1 + Hospital2 + Hospital3 + Hospital4 + Hospital5)


test_results <- list(
  t_test_1 = t.test(data$Hospital1, data$Hospital2),
  t_test_2 = t.test(data$Hospital3, data$Hospital4)
)

write.csv(data, "cancer_deaths_data.csv")

