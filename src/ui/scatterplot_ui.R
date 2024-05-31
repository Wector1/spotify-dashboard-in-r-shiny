scatterplot_ui <- tabPanel("Music trends in 2000-2022",
  verticalLayout(
       h3("Music trends in 2000-2022"),
       plotlyOutput("scatterplot", height = "700px")
  )
)