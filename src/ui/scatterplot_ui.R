scatterplot_ui <- tabPanel("Popularity vs. Danceability for different genres",
  fluidPage(
   sidebarLayout(
     sidebarPanel(
       textOutput("description")
     ),
     mainPanel(
       plotlyOutput("scatterplot")
     )
   )
  )
)