library(ggplot2)
library(plotly)

top_ui <- fluidPage(
  titlePanel("Top songs by country"),
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