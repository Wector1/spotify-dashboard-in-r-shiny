library(shiny)
library(spotifyr)
library(ggplot2)
library(plotly)
source("config.R")

Sys.setenv(SPOTIFY_CLIENT_ID = spotify_client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify_client_secret)
access_token <- get_spotify_access_token()
artist_id <- "None"
url <- "https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json"
world_geojson <- geojsonio::geojson_read(url, what = "sp")

function(input, output, session) {
  source("server/artist_server.R", local=TRUE)
  source("server/top_server.R", local=TRUE)
}
