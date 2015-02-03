# Preprocessing function of the NavigatoR: getting start and destination coordinates from a start and destination city and street.
# Authors: Michiel Blok and Madeleine van Winkel
# Created on Monday January 26 2015
## Description:
## This function downloads, unzips and reads the necessary data (infrastructure and administrative boundaries) for the NavigatoR.
## With this data, coordinates are created of the start and destination streets within the start and destination cities.


# Preprocessing function --------------------------------------------------
preprocessing <- function(placeStart, streetStart, placeDest, streetDest) {
  
  # Creation and reference to data folder -----------------------------------
  # Get working directory
  mainDir <- getwd()
  
  # Reference to data folder
  subDirData <- "data" 
  
  # Create data folder if it does not exist
  if (file.exists(subDirData)){
  } else {
    dir.create(file.path(mainDir, subDirData))
  }

  # Download and unzip the data ---------------------------------------------
  if (!require(downloader)) {
    download.file("http://download.geofabrik.de/europe/netherlands-latest.shp.zip", destfile = "data./netherlands-latest.shp.zip", "auto", quiet = TRUE, mode = "w")
  } else {
    download(url = "http://download.geofabrik.de/europe/netherlands-latest.shp.zip" , destfile = "data./netherlands-latest.shp.zip", quiet = TRUE, method = "auto")
  }
  unzip(zipfile = "data./netherlands-latest.shp.zip", exdir = paste(subDirData, ".", sep = "") , overwrite = TRUE)
  GADM <- raster::getData("GADM", country = "NLD", level = 2, path = "data")
  
  # Read infrastructure data ------------------------------------------------
  infra <- readOGR("data./roads.shp", layer = ogrListLayers("data./roads.shp"))
  
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
  
  X_Dest <- coordinates(streetDestData)[[1]][[1]][1,1]
  Y_Dest <- coordinates(streetDestData)[[1]][[1]][1,2]

  # Create SpatialPointDataFrames of start and destination point ------------
  XY_StartDest <- c(X_Start, X_Dest, Y_Start, Y_Dest)
  XY_StartDestMatrix <- matrix(XY_StartDest, ncol = 2)
  coordsdfStartDest <- data.frame(XY_StartDestMatrix, row.names = c("Start", "Destination"))
  names(coordsdfStartDest) <- c("X", "Y")
  
  # Add RD projection
  projectionRD <- CRS("+proj=longlat +datum=WGS84")
  coordsStartDest <- SpatialPointsDataFrame(coordsdfStartDest, coordsdfStartDest, proj4string = projectionRD, match.ID = TRUE, bbox = NULL)
  
  # Return data about the start and destination point -----------------------
  navigatoR.coords <- c("placeStart" = placeStart, "streetStart" = streetStart, "placeDest" =  placeDest, "streetDest" = streetDest, 
                        "X_Start" = X_Start, "Y_Start" = Y_Start, "X_Dest" = X_Dest, "Y_Dest" = Y_Dest, 
                        "coordsStartDest" = coordsStartDest, 
                        "infra" = infra)
  return (navigatoR.coords)
}