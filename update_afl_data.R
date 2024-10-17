# Clear environment variables
rm(list=ls())

# Initiate libraries -------------
library(fitzRoy)

# Create match results -----------
end_year = as.numeric(format(Sys.Date(), "%Y"))
seasons = 1897:end_year
match_results = fetch_results_afltables(seasons)
match_results$Date = as.Date(match_results$Date, "%Y-%m-%d")

# Compute winner of game
match_results$Winner.Location = ifelse(match_results$Margin >= 0, "Home","Away")
match_results$Winning.Team = ifelse(match_results$Margin >= 0, match_results$Home.Team, match_results$Away.Team)
match_results$Loosing.Team = ifelse(match_results$Margin >= 0, match_results$Away.Team, match_results$Home.Team)
match_results$Victory.Margin = abs(match_results$Margin)
match_results_extract = match_results[,c(2,17:20)]

# Output as csv
write.csv(match_results, file = "afl_match_results.csv", row.names = FALSE)
write.csv(match_results_extract, file = "afl_match_results_concise.csv", row.names = FALSE)
