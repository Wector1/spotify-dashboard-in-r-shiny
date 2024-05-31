library(dplyr)
library(plotly)
data <- read.csv("spotify_data/spotify_data.csv")

data_pruned <- data[, c("year", "popularity", "genre", "danceability", "instrumentalness", "loudness", "tempo", "speechiness", "acousticness")]

# drop data from 2023 because it is incomplete
data_pruned <- data_pruned[data_pruned$year != 2023, ]

data_aggregated <- data_pruned %>%
  group_by(year, genre) %>%
  summarise(avg_popularity = mean(popularity), avg_danceability = mean(danceability), avg_instrumentalness = mean(instrumentalness), avg_loudness = mean(loudness), avg_tempo = mean(tempo), avg_speechiness = mean(speechiness), avg_acousticness = mean(acousticness), count = n())

# export data_aggregated to a csv file
write.csv(data_aggregated, "spotify_data/spotify_data_aggregated.csv", row.names = FALSE)

animated_fig <- plot_ly(data_aggregated, x = ~avg_popularity, y = ~avg_danceability, color = ~count, text = ~genre, type = 'scatter', mode = 'markers', size = ~count, sizes = c(10, 100), frame = ~year) %>%
  layout(title = list(text='', font=list(
    color = "blue")), font = list(color = "blue", size = 15), 
    xaxis = list(title = 'Average popularity', titlefont = list(size = 20)),
    yaxis = list(title = 'Average danceability', titlefont = list(size = 20)),
    plot_bgcolor = 'white', paper_bgcolor = 'white'
  )
animated_fig