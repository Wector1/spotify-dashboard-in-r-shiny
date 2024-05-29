data_aggregated <- read.csv("spotify_data/spotify_data_aggregated.csv")

animated_fig <- plot_ly(data_aggregated, x = ~avg_popularity, y = ~avg_danceability, color = ~count, text = ~genre, type = 'scatter', mode = 'markers', size = ~count, sizes = c(10, 100), frame = ~year) %>%
  layout(title = list(text='', font=list(
    color = "blue")), font = list(color = "blue", size = 15), 
    xaxis = list(title = 'Average popularity', titlefont = list(size = 20)),
    yaxis = list(title = 'Average danceability', titlefont = list(size = 20)),
    plot_bgcolor = 'white', paper_bgcolor = 'white'
  )

output$scatterplot <- renderPlotly({
  animated_fig
})