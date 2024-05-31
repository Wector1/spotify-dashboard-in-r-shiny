library(shiny)

library(dplyr)
library(spotifyr)
library(tidyverse)
library(DT)




#formulaText <- reactive({
#  "Top 20 recommendations for you:"
#})

#output$caption <- renderText({
#  formulaText()
#})

output$table_recommendation <- DT::renderDT({
  genres <- input$genres
  recommendation <- get_recommendations(limit = 20, seed_tracks = '0c6xIDDpzE81m2q797ordA', seed_genres = genres, seed_artists = '3WrFJ7ztbogyGnTHbHJFl2', min_danceability = input$danceability[1], max_danceability = input$danceability[2], min_instrumentalness = input$instrumentalness[1], max_instrumentalness = input$instrumentalness[2], min_energy = input$energy[1], max_energy = input$energy[2], min_tempo = input$tempo[1], max_tempo = input$tempo[2], min_popularity = input$popularity[1], max_popularity = input$popularity[2], min_speechiness = input$speechiness[1], max_speechiness = input$speechiness[2])
  expanded_recommendation <- recommendation %>% unnest(artists, names_sep = "_") 
  pruned_recommendation <- expanded_recommendation %>% select(name, album.name, artists_name) %>% distinct(name, .keep_all = TRUE) %>% rename("Song Name" = name, "Album name" = album.name, "Artists name" = artists_name)
  output$caption <- renderText({
    paste("Top ", nrow(pruned_recommendation), " recommendations for you:")
  })
  
  datatable(pruned_recommendation, options = list(lengthChange = FALSE, searching = FALSE, paging = FALSE, info = FALSE))
})
