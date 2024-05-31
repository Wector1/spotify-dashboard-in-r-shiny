library(shiny)
library(leaflet)
library(DT)

top_ui <- tabPanel("Top Songs by Country",
                   tags$head(
                     tags$style(HTML("
      #world_map {
        height: 500px; /* Set a fixed height for the map */
        margin: 0;
        padding: 0;
      }
      .leaflet-container {
        background: #fff; /* Remove grey background */
      }
    "))
                   ),
                   verticalLayout(
                     h3(textOutput("country_name")),
                     leafletOutput("world_map", height = "500px"),
                     DT::DTOutput("top_country_datatable")
                   )
)