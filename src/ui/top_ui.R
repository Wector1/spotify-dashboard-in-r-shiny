library(shiny)
library(leaflet)
library(DT)

# Define the UI
top_ui <- tabPanel("Top Songs by Country",
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        textOutput("country_name")
      ),
      mainPanel(
        leafletOutput("world_map"),
        DT::DTOutput("top_country_datatable")
      )
    )
  )
)