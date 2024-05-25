library(ggplot2)
library(plotly)

countries = c("Gernamy",
              "France",
              "Poland",
              "Spain")

top_ui <- 
  tabPanel("Top songs by country",
           fluidPage(
                    selectInput("top_country", "Select country", countries, selected="PL", width="100%"), 
                    dataTableOutput("top_country_datatable")
             )
           )
