library(shiny)
library(spotifyr)
library(ggplot2)
library(plotly)
source("config.R")

Sys.setenv(SPOTIFY_CLIENT_ID = spotify_client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify_client_secret)
access_token <- get_spotify_access_token()
artist_id <- "None"

function(input, output, session) {
  source("server/artist_server.R", local=TRUE)
}
