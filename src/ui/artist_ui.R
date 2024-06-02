library(ggplot2)
library(plotly)

artist_ui <- 
  tabPanel("Artist info",
           fluidPage(
             column(width=10, 
                    tags$div(class="text-input", 
                             textInput("artist_id", 
                                       "",
                                       placeholder = "Artist name",
                                       width="100%"))
                    ),
             column(width=2, div( style="margin-top: 20px", actionButton("artist_search", "Search")))
             ),
           fluidPage(
             column(4, 
                    fluidRow(
                      tags$div(style="text-align: center !important",
                               uiOutput("artist_image")),
                      div(style="font-size:35px;
                                  text-align:center;
                                  margin: 10px 0px 0px !important;
                                  font-weight: bold;
                                  padding: 10px 0px 0px !important;",
                           textOutput("artist_name") %>% withSpinner(color = "#1CB752")),
                      div(class="text_normal",
                          "followers:"),
                      div(class="text_counter",
                          textOutput("artist_followers") %>% withSpinner(color = "#1CB752")),
                      tags$div(class='select',
                               selectInput("artist_plot_input",
                                           "Audio features",
                                           c("Overall", "Album"),
                                           selected="Overall",
                                           width="100%")), 
                      plotOutput("artist_plot") %>% withSpinner(color = "#1CB752")
                  )
             ),
            column(8,
             fluidRow(
                      tags$div(class='select', 
                               selectInput("artist_albums",
                                           "Artist's albums",
                                           c(),
                                           selected="None",
                                           width="100%")), 
                      tags$div(class="artist_iframe_c", uiOutput("artist_iframe"))
               )
             )
           ),
           fluidPage(
             plotlyOutput('audio_features_comparison') %>% withSpinner(color = "#1CB752")
           )
  )
