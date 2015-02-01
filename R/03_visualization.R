# Visualization function of the NavigatoR: visualized the route from start to destination and creates an KML file.
# Authors: Michiel Blok and Madeleine van Winkel
# Created on Monday January 26 2015
## Description:
## A plot is made from the clipped routemap.
## Using an iterative function, a growing arrow is added to show the route to take.
## As addition, a KML-file is created that opens up in Google Earth.
## An alternative of only creating an KML file and not opening it in Google Earth is added, for those who do not have Google Earth.


# Visualization function --------------------------------------------------
# Alternative function when Google Earth is not installed, KML-file can be generated without using Google Earth
visualization <- function (navigatoR.coords, navigatoR.calculation) {

  # Plot map with start and destination coordinates -------------------------
  plot(navigatoR.calculation$infraClip, main = "NavigatoR", xlab = "Longitude", ylab = "Latitude", cex = 2, col = "gray"(0.7), axes = TRUE)
  plot(navigatoR.coords$coordsStart, add = TRUE, col = "purple", lwd = 10)
  plot(navigatoR.coords$coordsDest, add = TRUE, col = "darkgreen", lwd = 10)
  box()
  grid()
  scalebar(d = round(abs(navigatoR.calculation$startToDestKm)), type = "line", lwd = 3, below = "kilometer", col = "black")
  legend("bottomright", legend = round(navigatoR.calculation$startToDestKm, digits = 3), title = "Distance (km)")

  # Add labels for start and destination point ------------------------------
  text(navigatoR.coords$X_Start, navigatoR.coords$Y_Start + navigatoR.calculation$Y_CoordsPlotText, labels = "Start", lwd = 35, col = "purple")
  text(navigatoR.coords$X_Dest, navigatoR.coords$Y_Dest + navigatoR.calculation$Y_CoordsPlotText, labels = "Destination", lwd = 35, col = "darkgreen")

  # Plot growing arrow on map -----------------------------------------------
  for (i in 1:10) {
    X_Temp <- navigatoR.coords$X_Start + ((i / 10) * (navigatoR.coords$X_Dest - navigatoR.coords$X_Start))
    Y_Temp <- navigatoR.coords$Y_Start + ((i / 10) * (navigatoR.coords$Y_Dest - navigatoR.coords$Y_Start))
    arrows(navigatoR.coords$X_Start, navigatoR.coords$Y_Start, X_Temp, Y_Temp, col = "blue", lwd = 3)
  }
  
  # Plot KML in Google Earth ------------------------------------------------
  plotKML(navigatoR.coords$coordsStartDest, folder.name = "output", file.name = "NavigatoR.kml", navigatoR.coords$coordsStartDest_names = c("Start", "Destination"), shape = "http://maps.google.com/mapfiles/kml/pal2/icon15.png", open.kml = TRUE)
  #writeOGR(points, file.path("output", "navigator.kml"), "NavigatoR", driver = "KML", overwrite_layer = TRUE)
}
