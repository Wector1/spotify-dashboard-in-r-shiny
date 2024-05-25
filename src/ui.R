library(shiny)
library(ggplot2)
library(plotly)
source("ui/artist_ui.R")

fluidPage(
  tabsetPanel(
    artist_ui,
  )
)
