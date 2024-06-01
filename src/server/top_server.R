selected_country <- reactiveVal(NULL)

output$world_map <- renderLeaflet({
  leaflet(world_geojson) %>%
    addPolygons(
      color = "#444444",
      weight = 1,
      fillColor = "#7D84B2",
      fillOpacity = 0.9,
      highlight = highlightOptions(
        weight = 2,
        color = "#666666",
        fillOpacity = 0.7,
        bringToFront = TRUE
      ),
      label = ~name,
      layerId = ~name
    ) %>%
    setMaxBounds(
      lng1 = -180,
      lat1 = -90,
      lng2 = 180,
      lat2 = 90
    )
})

observeEvent(input$world_map_shape_click, {
  backg <- htmltools::tags$style(".leaflet-container { background: tomato; }" )
  event <- input$world_map_shape_click
  selected_country(event$id)
  leafletProxy("world_map") %>%
    clearShapes() %>%
    addPolygons(
      data = world_geojson,
      color = "#444444",
      weight = 1,
      fillColor = ~ifelse(name == selected_country(), "#1CB752", "#7D84B2"),
      fillOpacity = 0.90,
      highlight = highlightOptions(
        weight = 2,
        color = "#666666",
        fillOpacity = 0.7,
        bringToFront = TRUE
      ),
      label = ~name,
      layerId = ~name
    ) %>%
    htmlwidgets::prependContent(backg) 
  output$country_name <- renderText({
    paste("Selected Country:", selected_country())
  })
  searched <- search_spotify(paste0('top 50 - ', selected_country()), 'playlist')
  playlist_id <- searched$id[1]
  playlist <- get_playlist(playlist_id)
  tracks <- playlist$tracks$items[c('track.name', 'track.artists', 'track.album.name', 'track.album.release_date', 'track.popularity')]
  # Extract only artist name from artist's object
  for (i in 1:nrow(tracks)) {
    tracks$track.artists[[i]] <- tracks$track.artists[[i]]$name
  }
  colnames(tracks) <- c("Name", "Artists", "Album Name", "Release Date", "Popularity")
  output$top_country_datatable <- renderDataTable({
    datatable(tracks, options = list(lengthChange = FALSE, searching = FALSE, paging = FALSE, info = FALSE))
  })
})
