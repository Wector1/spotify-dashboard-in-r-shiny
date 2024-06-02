library(shiny)
library(leaflet)
library(DT)

top_ui <- tabPanel("Top Songs by Country",
     tags$head(
       tags$style(HTML("
        #world_map {
          height: 900px; 
          margin: 0;
          padding: 0;
        }
        .leaflet-container {
          background: #fff; 
        }
      "))
     ),
     verticalLayout(
       h3(textOutput("country_name")),
       leafletOutput("world_map", height = "500px") %>% withSpinner(color = "#1CB752"),
       DT::DTOutput("top_country_datatable")
     )
)
