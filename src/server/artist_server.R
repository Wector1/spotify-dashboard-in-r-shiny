observeEvent(input$artist_search, {
  artist_id <<- search_spotify(as.character(input$artist_id), 'artist')$id[1]
  artist_info <- get_artist(artist_id)
  
  output$artist_image <- renderUI({
    div(
      tags$img(style="border-radius:50%; top-margin:20px", src=artist_info$images$url[1], 
               width=200, height=200)
    )
  })
  output$artist_name <- renderText ({artist_info$name})
  
  followers <- get_artists(artist_id)$followers.total
  output$artist_followers <- renderText({followers})
 
  # plot audio features
  redraw_audio_features(input, output, session)
  
  # update list of albums
  albums <- get_artist_albums(artist_id)
  albums_names <- c("Most popular songs", albums$name)
  updateSelectInput(session,"artist_albums",choices=albums_names, selected="Most popular songs")
  
  # tracks data table
  top_tracks <- get_artist_top_tracks(artist_id)
  top_tracks <- top_tracks[c("name", "album.name", "album.release_date", "popularity")]
  colnames(top_tracks) <- c("name", "album name", "release date", "popularity")
  
  output$artist_iframe <- renderUI({
   div(style="margin:20px",
     tags$iframe(id = "iframe",
                 style="border-radius:12px;",
                 src=paste0("https://open.spotify.com/embed/artist/",
                            artist_id, "?utm_source=generator"), 
                 width="100%",
                 height="650",
                 frameBorder="0",
                 allowfullscreen="",
                 
                 allow="autoplay; clipboard-write; encrypted-media; fullscreen;
                  picture-in-picture", loading="lazy")
   )
  })
})

observeEvent(input$artist_plot_input, {
  redraw_audio_features(input, output, session)
})

observeEvent(input$artist_albums, {
  # redraw plot with audio features
  redraw_audio_features(input, output, session)
  
  if (input$artist_albums == "Most popular songs") {
    output$artist_iframe <- renderUI({
      div(style="margin:20px",
        tags$iframe(id = "iframe",
                    style="border-radius:12px;",
                    src=paste0("https://open.spotify.com/embed/artist/",
                               artist_id,"?utm_source=generator"), 
                    width="100%",
                    height="650",
                    frameBorder="0",
                    allowfullscreen="",
                    allow="autoplay;
                           clipboard-write;
                           encrypted-media;
                           fullscreen;
                           picture-in-picture",
                           loading="lazy")
      )
    })
  } else if (artist_id != "None") {
    albums <- get_artist_albums(artist_id)
    selected_album_id <- albums[albums["name"] == input$artist_albums, ]$id
    
    output$artist_iframe <- renderUI({
      div(style="margin:20px",
        tags$iframe(id = "iframe",
                    style="border-radius:12px; background-color: #242331 !important;",
                    src=paste0("https://open.spotify.com/embed/album/",
                               selected_album_id, "?utm_source=generator"), 
                    width="100%",
                    height="650",
                    frameBorder="0",
                    allowfullscreen="",
                    allow="autoplay;
                           clipboard-write;
                           encrypted-media;
                           fullscreen;
                           picture-in-picture",
                    loading="lazy")
        )
    })
  }
})

redraw_audio_features <- function(input, output, session) {
  if(input$artist_plot_input == "Overall") {
    audio_features <- get_artist_audio_features(artist_id)
  } else if(input$artist_albums == "Most popular songs") {
    # collect audio features of most popular tracks
    top_tracks <- get_artist_top_tracks(artist_id)
    audio_features <- vector(mode = "list", length = nrow(top_tracks));
    i <- 1
    for (track in top_tracks$id) {
      audio_features[[i]] <- get_track_audio_features(track)
      i = i + 1
    }
    audio_features <- do.call("rbind", audio_features)
  } else {
    # collect audio features of album picked
    albums <- get_artist_albums(artist_id)
    selected_id <- albums[albums["name"] == input$artist_albums, ]$id
    selected_album_tracks <- get_album_tracks(selected_id)
    audio_features <- vector(mode = "list", length = nrow(selected_album_tracks));
    i <- 1
    for (track in selected_album_tracks$id) {
      audio_features[[i]] <- get_track_audio_features(track)
      i = i + 1
    }
    audio_features <- do.call("rbind", audio_features)
  }
  audio_features_values <- c(
    mean(audio_features$instrumentalness),
    mean(audio_features$energy),
    mean(audio_features$danceability),
    mean(audio_features$acousticness),
    mean(audio_features$liveness),
    mean(audio_features$speechiness)
  )
  
  d <- data.frame(x = 1:6, y = audio_features_values)
  vals <- lapply(d$y, function(y) seq(0, y, by = 0.01))
  y <- unlist(vals)
  mid <- rep(d$x, lengths(vals))
  d2 <- data.frame(x = mid - 0.45, xend = mid + 0.45, y = y, yend = y)
  
  p <- ggplot(data=d2, aes(x=x, xend=xend, y=y, end=yend, color=y)) +
    geom_segment(size = 2)+
    scale_color_gradient2(low = "green",
                          mid = "#00BB00",
                          high = "#242331",
                          midpoint=0.2) +
    theme_minimal() +
    theme(
      plot.background = element_rect(fill = '#242331', color = '#242331'),
      panel.grid = element_blank(),
      panel.border = element_blank(),
      axis.text.x = element_text(vjust = 0, color = "white", size = 16),
      axis.text.y = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      plot.title = element_text(hjust = 0.5, size = 40, face = "bold", color = "white"),
      legend.position = "none",
      plot.margin=unit(c(1, 1, 1, 1), 'cm')
    ) +
    scale_x_continuous(breaks=seq(1, 6, 1), 
                       labels=c(
                         'energy',
                         'instrumentalness',
                         'danceability',
                         'acousticness',
                         'liveness',
                         'speechiness')) +
    scale_y_continuous(expand = expansion(add = c(0.15, 0.15))) +
    coord_curvedpolar()
  
  output$artist_plot <- renderPlot({
    p
  }, bg="transparent")
}