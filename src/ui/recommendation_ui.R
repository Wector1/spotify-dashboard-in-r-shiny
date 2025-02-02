recommendation_ui <- tabPanel("Song Recommender",
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("genres", "Genres: (select up to 4 values)",
                           c("acoustic", "blues","brazil", "classical", "country", "disco", "hip-hop", "jazz", "metal", "movies", "pop", "reggae", "rock", "sleep", "soul", "tango", "techno")),
        
        sliderInput(inputId = "danceability",
                    label = "Danceability:",
                    min = 0,
                    max = 1,
                    value = c(0, 1)
        ),
        sliderInput(inputId = "instrumentalness",
                    label = "Instrumentalness:",
                    min = 0,
                    max = 1,
                    value = c(0, 1)
        ),
        sliderInput(inputId = "energy",
                    label = "Energy:",
                    min = 0,
                    max = 1,
                    value = c(0, 1)
        ),
        sliderInput(inputId = "tempo",
                    label = "Tempo: [BPM]",
                    min = 0,
                    max = 200,
                    value = c(0, 200)
        ),
        sliderInput(inputId = "popularity",
                    label = "Popularity:",
                    min = 0,
                    max = 100,
                    value = c(0, 100)
        ),
        sliderInput(inputId = "speechiness",
                    label = "Speechiness:",
                    min = 0,
                    max = 1,
                    value = c(0, 1)
        )
        
      ),
      
      mainPanel(
        h3(textOutput("caption")),
        DTOutput("table_recommendation") %>% withSpinner(color = "#1CB752")
      )
    )
  )
)