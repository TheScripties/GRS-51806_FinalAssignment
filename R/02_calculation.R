# Calculation function of the NavigatoR: calculates the extent for the routemap and the distance between the start and destination coordinates.
# Authors: Michiel Blok and Madeleine van Winkel
# Created on Monday January 26 2015
## Description:
## The extent of the routemap is clipped to the start and destination coordinates.
## The distance of the route from start to destination is calculated in meters.


# Calculation function to calculate the extent and distance ---------------
calculation <- function(navigatoR.coords) {
  # Clip to the extent of the route -----------------------------------------
  # Define X_Min, Y_Min, X_Max and Y_Max of the start and destination coordinates
  if (navigatoR.coords$X_Start <= navigatoR.coords$X_Dest) {
    X_Min <- navigatoR.coords$X_Start
    X_Max <- navigatoR.coords$X_Dest
  } else {
    X_Min <- navigatoR.coords$X_Dest
    X_Max <- navigatoR.coords$X_Start
  }
  
  if (navigatoR.coords$Y_Start <= navigatoR.coords$Y_Dest) {
    Y_Min <- navigatoR.coords$Y_Start
    Y_Max <- navigatoR.coords$Y_Dest
  } else {
    Y_Min <- navigatoR.coords$Y_Dest
    Y_Max <- navigatoR.coords$Y_Start
  }
  
  # Create the boundaries for the clipbox for x and y
  X_MaxExtentTemp <- X_Max + (1 / 5 * (X_Max - X_Min))
  Y_MaxExtentTemp <- Y_Max + (1 / 5 * (Y_Max - Y_Min))
  
  if (abs(X_MaxExtentTemp - X_Max) <= abs(Y_MaxExtentTemp - Y_Max)) {
    extentValue <- abs(Y_MaxExtentTemp - Y_Max)
  } else {
    extentValue <- abs(X_MaxExtentTemp - X_Max)
  }
  
  X_MinExtent <- X_Min - extentValue
  Y_MinExtent <- Y_Min - (2/3) * extentValue
  X_MaxExtent <- X_Max + extentValue
  Y_MaxExtent <- Y_Max + (2/3) *  extentValue
  Y_CoordsPlotText <- (5/12) * (Y_MaxExtent - Y_Max)
  
  # Define the extent of clipbox of the route
  extentRoute <- extent(X_MinExtent, X_MaxExtent, Y_MinExtent, Y_MaxExtent)
  
  # Clip infrastucture data to the extent of the route
  infraClip <- crop(navigatoR.coords$infra, extentRoute)
  
  # Calculate distance from start to destination ----------------------------
  startToDestM <- pointDistance(navigatoR.coords$coordsStartDest["Start",], navigatoR.coords$coordsStartDest["Destination",], lonlat = TRUE, allpairs = TRUE)
  startToDestKm <- startToDestM / 1000
  
  navigatoR.calculation <- c("Y_CoordsPlotText" = Y_CoordsPlotText, "infraClip" = infraClip, "startToDestKm" = startToDestKm)
  return (navigatoR.calculation)
}