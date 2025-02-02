# Spotify Dashboard

## Introduction

This dashboard is meant to be a comprehensive collection of various statistics regarding songs and artists available on Spotify.  
Additionally, it utilizes a recommender available via Spotify’s API to interactively propose songs suited for the user’s needs.

## How to use?

- **Artist info**  
  This tab offers the functionality of searching for a desired artist. To do that, enter the name of the artist of your choice and press the "Search" button.  
  Please note that it may take a few seconds for the page to load. The plot visible on the left side shows the analysis of an artist's audio features based on the average values of their songs or album.  
  An album might be chosen from the dropdown menu, displaying the pieces belonging to it.  
  A sample of a song might be played by pressing the button available in the widget.  

- **Top Songs by Country**  
  This tab provides the ability to display the most popular songs (currently) for a chosen country.  
  To pick a country, simply find it on the map (you can zoom in if needed) and click on it.  
  If everything worked as intended, the clicked shape should turn green, and a table with the ranking shall appear below it.  
  You can sort the table according to your needs.  

- **Song Recommender**  
  This tab takes advantage of the recommender function available via the Spotify API. Simply put, you can choose parameters of your liking using checkboxes and sliders.  
  The recommendations shall display in no time.  

  If you are interested in some technical details, it is worth mentioning that up to 4 genres can be chosen at once.  
  This is not due to our personal preference but rather due to Spotify's engine restrictions.  
  Furthermore, being too selective in terms of sliders may result in no recommendations being displayed (and therefore throwing an error).  

- **Music trends in 2000-2022**  
  This tab offers an interactive scatterplot, where you can observe how the popularity of songs in different genres evolved over the years.  
  Moreover, you can compare it with a statistic of your interest (among them: danceability, instrumentalness, loudness, and more).  
  Feel free to press the "Play" button visible below to see the changes over time.  
  Additional information about a chosen genre (represented by a dot) is displayed on hover.  
  Finally, you can zoom in and out, as well as reset the plot to its original state, thanks to implementation facilitated by Plotly.  

- **Top artists by year**  
  This plot provides a timeline of the most popular artists over the years 2017-2021 for a desired region.  
  You can choose the year of your interest as well as one of almost 70 regions using a selective dropdown menu, and the plot shall update accordingly.  
  In case the plot gets confusing, do not hesitate to select only a subset of artists by clicking on their names in the legend below.  
  For readability, only the top 6 artists' charts are displayed in color at once.  
  If you wish to see more data, you can hover over the selected artist to see their statistics.  
  The popularity of an artist is dictated by the position of their most successful song in the given week.  

## Sources

The majority of data used in this project was provided by [Spotify API](https://developer.spotify.com/documentation/web-api).  
For the sake of creating an interactive scatterplot, we used the [Spotify 1million tracks dataset](https://www.kaggle.com/datasets/amitanshjoshi/spotify-1million-tracks).  
The tab regarding top artists for each month in different countries was based on the [Daily Spotify charts](https://www.kaggle.com/datasets/dhruvildave/spotify-charts).  

## Authors

[addobosz](https://github.com/addobosz)  
[Wector1](https://github.com/Wector1)  
