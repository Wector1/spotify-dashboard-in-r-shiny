library(ggplot2)
library(plotly)

artist_ui <- 
  tabPanel("Artist info",
           fluidPage(
             column(width=10, 
                    tags$div(class="text-input", textInput("artist_id", "", placeholder = "Artist name", width="100%"))
                    ),
             column(width=2, div( style="margin-top: 20px", actionButton("artist_search", "Search")))
             ),
           fluidPage(
             column(4, 
                    fluidRow(
                      tags$div(style="text-align:center", uiOutput("artist_image")),
                      span(style="font-size:35px; text-align:center", textOutput("artist_name")),
                      span(style="font-size:20px; text-align:center", textOutput("artist_followers")),
                      plotlyOutput("artist_plot")
                  )
             ),
             column(8, 
                    tags$div(class='select', selectInput("artist_albums", "Artist's albums", c(), selected="None", width="100%")), 
                    dataTableOutput("artist_albums_datatable")
             )
           )
  )
