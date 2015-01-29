# Created on Thursday January 29 2015
# Preprocessing function for route planner for heavy transport.
# @authors: Michiel Blok and Madeleine van Winkel


# Preprocessing function --------------------------------------------------
preprocessing <- function(placeStart, streetStart, placeDest, streetDest) {
  placeStart <- placeStart
  streetStart <- streetStart
  placeDest <- placeDest
  streetDest <- streetDest
  
  # Reference to the data folder --------------------------------------------
  datdir <- "data"
  
  # Download and unzip the data ---------------------------------------------
  download(url = "http://download.geofabrik.de/europe/netherlands-latest.shp.zip" , destfile = "data/netherlands-latest.shp.zip", quiet = TRUE, method = "auto")
  unzip(zipfile = "data/netherlands-latest.shp.zip", exdir = paste(datdir, ".", sep = "") , overwrite = TRUE)
  GADM <- raster::getData("GADM", country = "NLD", level = 2, path = "data")
  
  # Read infrastructure data ------------------------------------------------
  infra <- readOGR("data/roads.shp", layer = ogrListLayers("data/roads.shp"))
  
  # Get start and destination city data -------------------------------------
  placeStartData <- GADM[GADM$NAME_2 == placeStart,]
  placeDestData <- GADM[GADM$NAME_2 == placeDest,]
  
  # Crop infrastructure to start and destination cities ---------------------
  cropStart <- crop(infra, placeStartData)
  cropDest <- crop(infra, placeDestData)
  
  # Get start and destination coordinates -----------------------------------
  streetStartData <- cropStart[cropStart$name == streetStart,]
  streetDestData <- cropDest[cropDest$name == streetDest,]
  
  X_Start <- coordinates(streetStartData)[[1]][[1]][1,1]
  Y_Start <- coordinates(streetStartData)[[1]][[1]][1,2]
  coordsdfStart <- data.frame(X_Start, Y_Start)
  
  X_Dest <- coordinates(streetDestData)[[1]][[1]][1,1]
  Y_Dest <- coordinates(streetDestData)[[1]][[1]][1,2]
  coordsdfDest <- data.frame(X_Dest, Y_Dest)
  
  # Create SpatialPointDataFrames of start and destination point ------------
  coordsStart <- SpatialPointsDataFrame(coordsdfStart, coordsdfStart, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL)
  coordsDest <- SpatialPointsDataFrame(coordsdfDest, coordsdfDest, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL)
  
  # Return data about the start and destination point -----------------------
  navigatoR.coords <- c("placeStart" = placeStart, "streetStart" = streetStart, "placeDest" =  placeDest, "streetDest" = streetDest, 
                        "X_Start" = X_Start, "Y_Start" = Y_Start, "X_Dest" = X_Dest, "Y_Dest" = Y_Dest, 
                        "coordsStart" = coordsStart, "coordsDest" = coordsDest, "infra" = infra)
  return (navigatoR.coords)
}