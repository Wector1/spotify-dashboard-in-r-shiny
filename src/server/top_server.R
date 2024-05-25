observeEvent(input$top_country, {
  searched <- search_spotify(paste0('top 50 - ', input$top_country), 'playlist')
  playlist_id <- searched$id[1]
  playlist <- get_playlist(playlist_id)
  tracks <- playlist$tracks$items[c('track.name', 'track.artists', 'track.album.name', 'track.album.release_date', 'track.popularity')]
  # extract only artist name from artist's object
  for (i in 1:50) {
    tracks$track.artists[[i]] <- tracks$track.artists[[i]]$name
  }
  colnames(tracks) <- c("name", "artists", "album name", "release date", "popularity")
  output$top_country_datatable <- renderDataTable(
    tracks
  )
})