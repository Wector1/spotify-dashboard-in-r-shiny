about_ui <- tabPanel("About",
   verticalLayout(
     div(
       style = "text-align: center; margin-top: 20px",
       img(src='logo.png', height = 168, width = 269),
     ),
     h3("Spotify Dashboard"),
     h4("Introduction"),
     p("This dashboard is meant to be a comprehensive collection of various statistics regarding songs and artists available on Spotify. \nAdditionally, it utilizes  recommender available via Spotify’s API, in order to interactively propose songs suited for the user’s needs."),
     h4("How to use?"),
     HTML("<ul><li><b>Artist info</b><p>This tab offers functionality of searching for a desired artist. In order to
          do that, you can enter the name of the artist of your choice and press the \"Search\" button. Please note
          that it may take a few seconds for the page to load. The plot visible on the left side shows the anaylsis of
          artist's audio features based on the average values of their songs or album. An album might be chosen from the dropdown menu, displaying the pieces belonging to it.
          The sample of a song might be played by pressing the button available in the widget.
          </p></li><li><b>Top Songs by Country</b><p>
          This tab provides a possibility of displaying most popular songs (currently) for a chosen country. To pick a country,
          simply find it on the map (you can zoom in if needed), and click on it. If everything worked as intended, clicked shape
          should turn green, and a table with ranking shall appear below it. You can sort the table according to your needs. </p></li><li><b>
          Song Recommender</b><p>
          This tab takes advantage of recommender function available via Spotify API. Simply speaking, you can choose parameters of your liking using
          checkboxes and sliders. The recommendations shall display in no time. \n
          If you are interested in some technical details, it is worth mentioning that up to 4 genres can be choosen at once.
          This is not due to our personal preference, but rather to spotify engine's restrictions. Furthermore, being too selective in terms of sliders 
          may result in no recommendations being displayed (and therefore throwing an error).
          </p></li><li><b>Music trends in 2000-2022</b><p>
          This tab offers an interactive scatterplot, where you can observe how the popularity of songs in different genres evolved over the years.
          Moreover, you can compare it with a statistic of your interest (among them danceability, instrumentalness, loudness and more).
          Feel free to press the \"Play\" button visible below, to see the changes over time. Additional information about a chosen genre (represented by dot) 
          are displayed on hover. Finally, you can zoom in and out, as well as reset the plot to its original state, thanks to implementation facilitated by Plotly.
          </p></li><li><b>Top artists by year</b><p>
          This plot provides a timeline of the most popular artists over years 2017-2021 for a desired region. You can choose the year of your interest as well as 
          one of almost 70 regions, using a selective dropdown menu, and the plot shall update accordingly.
          In case the plot gets confusing, do not hesitate to select only a subset of artists, by clicking on their names in the legend below.
          For the sake of readability, only the top 6 artists' charts are displayed in colour at once.
          If you wish to see more data, you can hover over the selected artist to see their statistics.
          Popularity of an artist is dictated by the position of their most successful song in the given week.  
          </p></li></ul>"),
     h4("Sources"),
     HTML("<p>The majority of data used in this project was provided by <a href=`https://developer.spotify.com/documentation/web-api`>Spotify API</a>.<br>
    For the sake of creating interactive scatterplot, we used <a href=`https://www.kaggle.com/datasets/amitanshjoshi/spotify-1million-tracks`>Spotify 1million tracks dataset</a>.<br>
    The tab regarding top artists for each month in different countries was based on the <a href=`https://www.kaggle.com/datasets/dhruvildave/spotify-charts`>Daily Spotify charts</a>.</p>"),
    
     h4("Authors"),
     a(href="github.com/addobosz", "addobosz"),
     a(href="github.com/Wector1", "Wector1")
   )
)
