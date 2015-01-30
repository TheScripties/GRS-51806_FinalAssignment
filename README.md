<h5>
  GRS-51806_FinalAssignment - NavigatoR <br> </br>
  Authors: Michiel Blok and Madeleine van Winkel <br> </br>
  Created on Friday January 30 2015 <br> </br>
</h5>

<h2>
  Contents
</h2>

<h5> </b>
  1 - NavigatoR <br> </br>
  2 - Scripts <br> </br>
  2.a - Main Script (main.R) <br> </br>
  2.b - Preprocessing Script (R/01_preprocessing.R) <br> </br>
  2.c - Calculation Script (R/02_calculation.R) <br> </br>
  2.d - Visualization Script (R/03_visualization.R) <br> </br>
  3 - Examples <br> </br>
</h5>

<h2>
  1 - NavigatoR  <br> </br>
</h2>

<h5>
  This is the NavigatoR package. <br> </br>
  It calculates and plots the distance between 2 locations within the Netherlands. <br> </br>
  The authors wish you a lot of fun with the NavigatoR! <br> </br>
</h5>

<h2>
  2 - Scripts <br> </br>
</h2>

<h5>
  The NavigatoR consist of the following 4 scripts that will be discussed below: <br> </br>
  # main.R <br> </br>
  ## 01_preprocessing.R <br> </br>
  ## 02_calculation.R <br> </br>
  ## 03_visualization.R <br> </br>
</h5>

<h2>
  2.a - Main Script (main.R) <br> </br>
</h2>

<h5>
  This is the main script of the NavigatoR. <br> </br>
  This script will check whether packages need to be installed, and will install these packages if needed. It will also load the required packages. <br> </br>
  Afterwards, the source functions are created and defaults are given to try out the script. <br> </br>
  Finally, the functions that this programs exists of are called and runned. <br> </br>
</h5>

<h2>
  2.b - Preprocessing Script (R/01_preprocessing.R) <br> </br>
</h2>

<h5>
  This is the preprocessing script of the NavigatoR. <br> </br>
  This function downloads, unzips and reads the necessary data (infrastructure and administrative boundaries). <br> </br>
  With this data, coordinates are created for the start and destination streets within the start and destination cities. <br> </br>
</h5>

<h2>
  2.c - Calculation Script (R/02_calculation.R) <br> </br>
</h2>

<h5>
  This is the calculation script of the NavigatoR. <br> </br>
  This function clipped the extent of the routemap to the start and destination coordinates. <br> </br>
  The distance of the route from start to destination is also calculated (in meters). <br> </br>
</h5>

<h2>
  2.d - Visualization Script (R/03_visualization.R) <br> </br>
</h2>

<h5>
  This is the visualization script of the NavigatoR. <br> </br>
  This function creates a plot from the clipped routemap, containing also the start and destination points. <br> </br>
  Using an iterative function, a growing arrow is added to show the route from start to destination. <br> </br>
  As addition, a KML-file is created that opens up in Google Earth. <br> </br>
  An alternative of only creating an KML file and not opening it in Google Earth is added, for those who do not have Google Earth. <br> </br>
</h5>

<h2>
  3 - Examples <br> </br>
</h2>

<h5>
  The function takes 4 string arguments: <br> </br>
  # placeStart (the city from where the route should be created) <br> </br>
  # streetStart (the street from where the route should be created) <br> </br>
  # placeDest (the city to where the route should go) <br> </br>
  # streetDest (the street to where the route should go) <br> </br>
</h5>

<h5>
  Examples of these arguments could be from Gordelweg, Rotterdam to Slotlaan, Capelle aan den IJssel <br> </br>
  # "Rotterdam" (paceStart) <br> </br>
  # "Gordelweg" (streetStart) <br> </br>
  # "Capelle aan den IJssel" (placeDest) <br> </br>
  # "Slotlaan" (streetDest) <br> </br>
</h5>

<h5>
  or for example <br> </br>
  # "Wageningen" (placeStart) <br> </br>
  # "Haarweg" (streetStart) <br> </br>
  # "Wageningen" (placeDest) <br> </br>
  # "Troelstraweg" (streetDest) <br> </br>
</h5>
