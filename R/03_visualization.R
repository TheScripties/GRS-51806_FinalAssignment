# Created on Thursday January 29 2015
# Visualization function for route planner for heavy transport
# @authors: Michiel Blok and Madeleine van Winkel


# Visualization function --------------------------------------------------
visualization <- function (navigatoR.coords, navigatoR.calculation) {

  # Plot map with start and destination coordinates -------------------------
  plot(navigatoR.calculation$infraClip, main = "NavigatoR", xlab = "Longitude", ylab = "Latitude", cex = 2, col = "gray"(0.7))
  plot(navigatoR.coords$coordsStart, add = TRUE, col = "purple", lwd = 10)
  plot(navigatoR.coords$coordsDest, add = TRUE, col = "darkgreen", lwd = 10)
  box()
  grid()
  scalebar(d = round (abs(navigatoR.coords$X_Dest - navigatoR.coords$X_Start) / 100, digits = 0) * 10, lwd = 1)
  legend("bottomright", legend = navigatoR.calculation$startToDestKm, title = "Distance")

  # Add labels for start and destination point ------------------------------
  text(navigatoR.coords$X_Start, navigatoR.coords$Y_Start + navigatoR.calculation$Y_CoordsPlotText, labels = "Start", lwd = 35, col = "purple")
  text(navigatoR.coords$X_Dest, navigatoR.coords$Y_Dest + navigatoR.calculation$Y_CoordsPlotText, labels = "Destination", lwd = 35, col = "darkgreen")

  # Plot growing arrow on map -----------------------------------------------
  for (i in 1:10) {
    X_Temp <-  navigatoR.coords$X_Start + ((i / 10) * (navigatoR.coords$X_Dest - navigatoR.coords$X_Start))
    Y_Temp <-  navigatoR.coords$Y_Start + ((i / 10) * (navigatoR.coords$Y_Dest - navigatoR.coords$Y_Start))
    arrows(navigatoR.coords$X_Start, navigatoR.coords$Y_Start, X_Temp, Y_Temp, col = "blue", lwd = 5)
  }
  
  # Plot KML in Google Earth ------------------------------------------------
  plotKML(points, file.path("output", "navigator.kml"), points_names = c("Start", "Destination"), shape = "http://maps.google.com/mapfiles/kml/pal2/icon15.png", open.kml = TRUE)
  # Alternative for when Google Earth is not installed
  #writeOGR(points, file.path("output", "navigator.kml"), "NavigatoR", driver = "KML", overwrite_layer = TRUE)
}


