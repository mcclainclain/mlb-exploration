# Script to get data from all regular season gamelogs for game durations. 

# Libraries
library(tidyverse)
library(lubridate)

# Get files in cwd
files = list.files(".")

# Get header vector
header = read_csv("https://raw.githubusercontent.com/maxtoki/baseball_R/master/data/game_log_header.csv", col_names = FALSE)

# Start a new data frame for appending rows
durations = data.frame()

# Remove non-regular season files from list
files = files[!files %in% c("glas.txt", "gldv.txt", "gllc.txt", "glwc.txt", "glws.txt")]

# Loop through all regular season data, parsing to keep duration and date values, before appending to durations dataframe
for (i in 1:length(files)) {
  df = read_csv(files[i], col_names = FALSE)
  colnames(df) = header
  df[["Date"]] = as.Date(as.character(df[["Date"]]), "%Y%m%d")
  df = df %>% mutate(Year = year(Date), Month = month(Date), Day = day(Date)) %>% select(Year, Month, Day, Duration)
  
  durations = rbind(durations, df)
}

# Write dataframe to durations.csv
write_csv(durations, "durations.csv")

