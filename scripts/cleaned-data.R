
set.seed(123)
library(dplyr)
library(ggplot2)
library(rstanarm)


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

# Calculate total deaths
data <- data %>%
  mutate(TotalDeaths = Hospital1 + Hospital2 + Hospital3 + Hospital4 + Hospital5)

# Plotting with ggplot2
ggplot(data, aes(x = Year)) +
  geom_line(aes(y = Hospital1, color = "Hospital 1")) +
  geom_line(aes(y = Hospital2, color = "Hospital 2")) +
  geom_line(aes(y = Hospital3, color = "Hospital 3")) +
  geom_line(aes(y = Hospital4, color = "Hospital 4")) +
  geom_line(aes(y = Hospital5, color = "Hospital 5")) +
  labs(title = "Cancer Deaths in Sydney's Hospitals (2004-2023)",
       y = "Number of Deaths",
       color = "Hospital") +
  theme_minimal()

# Modeling with rstanarm
model <- stan_glm(TotalDeaths ~ Year, data = data, family = gaussian)

# Save data and plot
write.csv(data, "cancer_deaths_data.csv")
ggsave("cancer_deaths_plot.png")

# Save model summary
write.csv(summary(model)$coefficients, "model_summary.csv")

