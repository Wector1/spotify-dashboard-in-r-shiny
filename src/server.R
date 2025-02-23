library(shiny)
library(spotifyr)
library(ggplot2)
library(plotly)
library(conflicted)
library(geomtextpath)
library(leaflet)
library(sf)
library(sp)
library(DT)
library(shinycssloaders)
source("config.R")

conflicts_prefer(DT::renderDataTable())
conflicts_prefer(DT::dataTableOutput())
conflicts_prefer(plotly::layout())

Sys.setenv(SPOTIFY_CLIENT_ID = spotify_client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify_client_secret)
access_token <- get_spotify_access_token()
artist_id <- "None"
url <- "https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json"

world_geojson <- st_read(url)
audio_features <- "None"

function(input, output, session) {
  source("server/artist_server.R", local=TRUE)
  source("server/top_server.R", local=TRUE)
  source("server/recommendation_server.R", local=TRUE)
  source("server/scatterplot_server.R", local=TRUE)
  source("server/top_artists_server.R", local=TRUE)
}
