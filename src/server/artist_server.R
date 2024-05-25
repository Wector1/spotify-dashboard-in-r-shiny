observeEvent(input$artist_search, {
  artist_id <<- search_spotify(as.character(input$artist_id), 'artist')$id[1]
  artist_info <- get_artist(artist_id)
  
  output$artist_image <- renderUI({
    div(
      tags$img(style="border-radius:50%", src=artist_info$images$url[1], width=200, height=200)
    )
  })
  output$artist_name <- renderText ({artist_info$name})
  
  followers <- get_artists(artist_id)$followers.total
  output$artist_followers <- renderText ({paste("followers:", followers)})
  
  # polar plot
  audio_features <- get_artist_audio_features(artist_id)
  audio_features_names <- c('instrumentalness', 'energy', 'danceability', 'acousticness', 'liveness', 'speechiness')
  audio_features_values <- c(
    mean(audio_features$instrumentalness),
    mean(audio_features$energy),
    mean(audio_features$danceability),
    mean(audio_features$acousticness),
    mean(audio_features$liveness),
    mean(audio_features$speechiness)
  )
  fig <- plot_ly(
    type = 'scatterpolar',
    mode='markers',
    r = audio_features_values,
    theta = audio_features_names,
    fill = 'toself'
  ) 
  fig <- fig %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = T,
          range = c(0,1)
        )
      ),
      showlegend = F,
      margin=c(50, 50, 50, 50)
    )
  output$artist_plot <- renderPlotly({
    fig
  })
  
  # update list of albums
  albums <- get_artist_albums(artist_id)
  albums_names <- c("Most popular songs", albums$name)
  updateSelectInput(session,"artist_albums",choices=albums_names, selected="Most popular songs")
  
  # tracks data table
  top_tracks <- get_artist_top_tracks(artist_id)
  top_tracks <- top_tracks[c("name", "album.name", "album.release_date", "popularity")]
  colnames(top_tracks) <- c("name", "album name", "release date", "popularity")
  top_tracks
  output$artist_albums_datatable <- renderDataTable(
    top_tracks
  )
})

observeEvent(input$artist_albums, {
  if (input$artist_albums == "Most popular songs") {
    top_tracks <- get_artist_top_tracks(artist_id)
    top_tracks <- top_tracks[c("name", "album.name", "album.release_date", "popularity")]
    colnames(top_tracks) <- c("name", "album name", "release date", "popularity")
    
    output$artist_albums_datatable <- renderDataTable(
      top_tracks
    )
  } else if (artist_id != "None") {
    albums <- get_artist_albums(artist_id)
    selected_id <- albums[albums["name"] == input$artist_albums, ]$id
    album_tracks <- get_album_tracks(selected_id)
    album_tracks <- album_tracks[c("name")]
    album_tracks["album name"] <- input$artist_albums
    album_tracks["release date"] <- albums[albums["name"] == input$artist_albums, ]$release_date
    
    output$artist_albums_datatable <- renderDataTable(
      album_tracks
    )
  }
})