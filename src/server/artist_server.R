observeEvent(input$artist_search, {
  if (input$artist_id != ' ') {
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
    
    # plot audio features comparison
    render_audio_features_comparison(input, output, session)
    
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
  }
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

render_audio_features_comparison <- function(input, output, session) {
  audio_features <- get_artist_audio_features(artist_id)
  audio_features <- audio_features[c('album_release_year',
                                     'energy',
                                     'instrumentalness',
                                     'danceability',
                                     'acousticness',
                                     'liveness',
                                     'speechiness')]
  
  audio_features <- aggregate(audio_features, 
                              by = list(audio_features$album_release_year), 
                              FUN = mean) %>%
    arrange(album_release_year)
  
  fig <- plot_ly(audio_features, x=~album_release_year, y=~energy, name='energy', type='scatter', mode='lines', line=list(color='#1CB752'),
                 hovertemplate=paste('<br><b>Year:</b> %{x}</br>',
                                     '<b>Value:</b> %{y}',
                                     '<extra></extra>'))
  fig <- fig %>% add_trace(y=~instrumentalness, name='instrumentalness', type='scatter', mode='lines', line=list(color='#FF0022'))
  fig <- fig %>% add_trace(y=~danceability, name='danceability', type='scatter', mode='lines', line=list(color='#B91372'))
  fig <- fig %>% add_trace(y=~acousticness, name='acousticness', type='scatter', mode='lines', line=list(color='#FCFAF9'))
  fig <- fig %>% add_trace(y=~liveness, name='liveness', type='scatter', mode='lines', line=list(color='#7D84B2'))
  fig <- fig %>% add_trace(y=~speechiness, name='speechiness', type='scatter', mode='lines', line=list(color='#F0E100'))
  fig <- fig %>% layout(yaxis=list(range=list(0,1),
                                   title='',
                                   tickfont=list(size=15),
                                   color='#E8E8E8'),
                        xaxis=list(color='#E8E8E8',
                                   title='Album release year',
                                   tickfont=list(size=15),
                                   titlefont=list(size=22),
                                   dtick=(floor((tail(audio_features$album_release_year, n=1) - 
                                                  audio_features$album_release_year[1]) / 5)),
                                   tick0=audio_features$album_release_year[1]),
                        legend=list(font=list(size=15)),
                        font=list(color='#E8E8E8'),
                        plot_bgcolor='#242331',
                        paper_bgcolor='#242331')
  output$audio_features_comparison <- renderPlotly(
    fig
  )
}

redraw_audio_features <- function(input, output, session) {
  if (artist_id != "None") {
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
      mean(audio_features$energy),
      mean(audio_features$instrumentalness),
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
}