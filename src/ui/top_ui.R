library(shiny)
library(leaflet)
library(DT)

# Define the UI
top_ui <- tabPanel("Top Songs by Country",
  verticalLayout(
        h3(textOutput("country_name")),
        leafletOutput("world_map"),
        DT::DTOutput("top_country_datatable")
  )
)