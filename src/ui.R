library(shiny)
library(ggplot2)
library(plotly)
source("ui/artist_ui.R")
source("ui/top_ui.R")

fluidPage(
  tabsetPanel(
    artist_ui,
    top_ui
  )
)
