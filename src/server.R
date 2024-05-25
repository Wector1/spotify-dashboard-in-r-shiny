library(shiny)

source("config.R")

Sys.setenv(SPOTIFY_CLIENT_ID = spotify_client_id)
Sys.setenv(SPOTIFY_CLIENT_SECRET = spotify_client_secret)
access_token <- get_spotify_access_token()

function(input, output, session) {

}
