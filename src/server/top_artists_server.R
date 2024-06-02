observeEvent(input$top_artists_region, {
  render_top_artists_by_year(input, output, session)
})

observeEvent(input$top_artists_year, {
  render_top_artists_by_year(input, output, session)
})

render_top_artists_by_year <- function(input, output, session) {
  data <- read.csv(paste0("../data/charts_top200_", input$top_artists_region, ".csv"))

  data <- data[data['year'] == input$top_artists_year, ]
  data$rank <- strsplit(data$rank, ';')
  data$dates <- strsplit(data$dates, ';')
  for (x in 1:nrow(data)) {
    data[x, ]$rank <- list(as.numeric(unlist(data[x, ]$rank)))
    data[x, ]$dates <- list(as.Date(unlist(data[x, ]$dates)))
  }
  colors = c('#1CB752', '#F0E100', '#7D84B2', '#FCFAF9', '#B91372', '#FF0022', '#3D383B77', '#3D383B77', '#3D383B77', '#3D383B77', '#3D383B77', '#3D383B77')
  fig <- plot_ly(data)
  for (x in min(100, nrow(data)):1) {
    rank <- data[x, ]$rank[[1]]
    date <- data[x, ]$date[[1]]
    artist <- rep(data[x, ]$artist, length(date))
    data_to_plot <- data.frame(rank, date, artist)
    if (data[x, ]$rank_overall < 6) {
      fig <- add_trace(fig, 
                       data=data_to_plot,
                       x=~date,
                       y=~rank,
                       type='scatter',
                       mode='lines+markers',
                       meta=data[x, ]$artist,
                       line = list(color = colors[data[x, ]$rank_overall + 1], width=4),
                       marker = list(color = colors[data[x, ]$rank_overall + 1], size=10),
                       hovertemplate=paste('<b>Date:</b> %{x}',
                                           '<br><b>Rank:</b> %{y}</br>',
                                           '<b>Artist:</b> %{meta}',
                                           '<extra></extra>'),
                       name=data[x, ]$artist)
    } else {
      fig <- add_trace(fig, 
                       data=data_to_plot,
                       x=~date,
                       y=~rank,
                       type='scatter',
                       mode='lines+markers',
                       meta=data[x, ]$artist,
                       line = list(color = colors[data[x, ]$rank_overall + 1], width=4),
                       marker = list(color = colors[data[x, ]$rank_overall + 1], size=10),
                       name=data[x, ]$artist,
                       hovertemplate=paste('<b>Date:</b> %{x}',
                                           '<br><b>Rank:</b> %{y}</br>',
                                           '<b>Artist:</b> %{meta}',
                                           '<extra></extra>'),
                       showlegend=F)
    }
  }
  
  output$top_artists_by_year <- renderPlotly(
    fig <- fig %>% layout(
      yaxis=list(title='Position',
                 tickfont=list(size=15),
                 titlefont=list(size=22),
                 color='#E8E8E8'),
      xaxis=list(color='#E8E8E8',
                 title='Date',
                 tickfont=list(size=15),
                 titlefont=list(size=22)),
      hoverlabel=list(bgcolor='#243231'),
      legend=list(orientation='h', y=-0.7, font=list(size=15)),
      font=list(color='#E8E8E8'),
      plot_bgcolor='#242331',
      paper_bgcolor='#242331')
  )
}
