<h4>
  # GRS-51806_FinalAssignment - NavigatoR
  # Authors: Michiel Blok and Madeleine van Winkel
  # Created on Friday January 30 2015
</h4>

<h1>
  ## Contents --------------------------------------------------------------------------------------------
</h1>

<h4>
  # Heading 1 - NavigatoR
  # Heading 2 - Scripts
  ## Heading 2.a - Main Script (main.R)
  ## Heading 2.b - Preprocessing Script (R/01_preprocessing.R)
  ## Heading 2.c - Calculation Script (R/02_calculation.R)
  ## Heading 2.d - Visualization Script (R/03_visualization.R)
  ## Heading 3 - Examples
</h4>

<h1>
  ## Heading 1 - NavigatoR ------------------------------------------------------------------------------
</h1>

<h4>
  # This is the NavigatoR package.
  # It calculates and plots the distance between 2 locations within the Netherlands.
  # The authors wish you a lot of fun with the NavigatoR!
</h4>

<h1>
  ## Heading 2 - Scripts --------------------------------------------------------------------------------
</h1>

<h4>
  # The NavigatoR consist of the following 4 scripts that will be discussed below:
  ## main.R
  ## 01_preprocessing.R
  ## 02_calculation.R
  ## 03_visualization.R
</h4>

<h1>
  ## Heading 2.a - Main Script (main.R) ----------------------------------------------------------------
</h1>

<h4>
  # This is the main script of the NavigatoR. 
  # This script will check whether packages need to be installed, and will install these packages if needed. It will also load the required packages.
  # Afterwards, the source functions are created and defaults are given to try out the script.
  # Finally, the functions that this programs exists of are called and runned.
</h4>

<h1>
  ## Heading 2.b - Preprocessing Script (R/01_preprocessing.R) -----------------------------------------
</h1>

<h4>
  # This is the preprocessing script of the NavigatoR.
  # This function downloads, unzips and reads the necessary data (infrastructure and administrative boundaries).
  # With this data, coordinates are created for the start and destination streets within the start and destination cities.
</h4>

<h1>
  ## Heading 2.c - Calculation Script (R/02_calculation.R) ---------------------------------------------
</h1>

<h4>
  # This is the calculation script of the NavigatoR.
  # This function clipped the extent of the routemap to the start and destination coordinates.
  # The distance of the route from start to destination is also calculated (in meters).
</h4>

<h1>
  ## Heading 2.d - Visualization Script (R/03_visualization.R) -----------------------------------------
</h1>

<h4>
  # This is the visualization script of the NavigatoR.
  # This function creates a plot from the clipped routemap, containing also the start and destination points.
  # Using an iterative function, a growing arrow is added to show the route from start to destination.
  # As addition, a KML-file is created that opens up in Google Earth.
  # An alternative of only creating an KML file and not opening it in Google Earth is added, for those who do not have Google Earth.
</h4>

<h1>
  ## Heading 3 - Examples ------------------------------------------------------------------------------
</h1>

<h4>
  # The function takes 4 string arguments:
  ## placeStart (the city from where the route should be created)
  ## streetStart (the street from where the route should be created)
  ## placeDest (the city to where the route should go)
  ## streetDest (the street to where the route should go)
</h4>

<h4>
  # Examples of these arguments could be from Gordelweg, Rotterdam to Slotlaan, Capelle aan den IJssel
  ## "Rotterdam" (paceStart)
  ## "Gordelweg" (streetStart)
  ## "Capelle aan den IJssel" (placeDest)
  ## "Slotlaan" (streetDest)
</h4>

<h4>
  # or for example
  ## "Wageningen" (placeStart)
  ## "Haarweg" (streetStart)
  ## "Wageningen" (placeDest)
  ## "Troelstraweg" (streetDest)
</h4>
