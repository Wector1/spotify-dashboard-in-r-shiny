data_aggregated <- read.csv("spotify_data/spotify_data_aggregated.csv")

# normalize the averages for better visualization
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

data_aggregated$avg_popularity <- normalize(data_aggregated$avg_popularity)
data_aggregated$avg_danceability <- normalize(data_aggregated$avg_danceability)
data_aggregated$avg_instrumentalness <- normalize(data_aggregated$avg_instrumentalness)
data_aggregated$avg_loudness <- normalize(data_aggregated$avg_loudness)
data_aggregated$avg_tempo <- normalize(data_aggregated$avg_tempo)
data_aggregated$avg_speechiness <- normalize(data_aggregated$avg_speechiness)
data_aggregated$avg_acousticness <- normalize(data_aggregated$avg_acousticness)

animated_fig <- plot_ly(data_aggregated, x = ~avg_popularity, y = ~avg_danceability, color = ~count, text = ~genre, type = 'scatter', mode = 'markers', frame = ~year) %>%
  layout(
    title = list(text = '', font = list(color = "blue")),
    font = list(color = "blue", size = 15),
    xaxis = list(title = 'Average popularity', titlefont = list(size = 20)),
    yaxis = list(title = 'Average danceability', titlefont = list(size = 20)),
    plot_bgcolor = 'white', paper_bgcolor = 'white',
    updatemenus = list(
      list(
        buttons = list(
          list(
            method = "update",
            args = list(
              list(y = list(~avg_danceability)),
              list(yaxis = list(title = 'Average danceability'))
            ),
            label = "Danceability"
          ),
          list(
            method = "update",
            args = list(
              list(y = list(~avg_instrumentalness)),
              list(yaxis = list(title = 'Average instrumentalness'))
            ),
            label = "Instrumentalness"
          ),
          list(
            method = "update",
            args = list(
              list(y = list(~avg_loudness)),
              list(yaxis = list(title = 'Average loudness [dB]'))
            ),
            label = "Loudness"
          ),
          list(
            method = "update",
            args = list(
              list(y = list(~avg_tempo)),
              list(yaxis = list(title = 'Average tempo [BPM]'))
            ),
            label = "Tempo"
          ),
          list(
            method = "update",
            args = list(
              list(y = list(~avg_speechiness)),
              list(yaxis = list(title = 'Average speechiness'))
            ),
            label = "Speechiness"
          ),
          list(
            method = "update",
            args = list(
              list(y = list(~avg_acousticness)),
              list(yaxis = list(title = 'Average acousticness'))
            ),
            label = "Acousticness"
          )
        ),
        direction = "down",
        x = 0.1,
        xanchor = "left",
        y = 1.15,
        yanchor = "top"
      )
    )
  )

output$scatterplot <- renderPlotly({
  animated_fig
})