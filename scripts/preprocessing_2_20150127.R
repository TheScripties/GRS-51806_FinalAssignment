
# Defaults for places and streets -----------------------------------------
placeStart = "Rotterdam" # (GADM_NAME_2)
streetStart = "Gordelweg" # evt. Coolsingel # (infra)
placeDest = "Capelle aan den IJssel" # (GADM_NAME_2)
streetDest = "Slotlaan" # (infra)

# Preprocessing function --------------------------------------------------
processing <- function(placeStart, streetStart, placeDest, streetDest) {
  
  datdir <- 'data' # comment erboven plaatsen?
  
  # Download and unzip the data ---------------------------------------------
  # create folder data (or upload data folder to github, otherwise the download does not work)
  download(url = "http://download.geofabrik.de/europe/netherlands-latest.shp.zip" , destfile = "data/netherlands-latest.shp.zip", quiet = TRUE, method = "auto")  
  OSMfiles <- unzip(zipfile = paste(datdir, "/netherlands-latest.shp.zip", sep = "") , exdir = paste(datdir, ".", sep = "") , overwrite = TRUE)
  GADM <- raster::getData("GADM", country = "NLD", level = 2, path = "data")
  
  # Reference to the files --------------------------------------------------
  dsnInfra <- OSMfiles[OSMfiles == paste(datdir, './roads.shp' , sep = "")]
  dsnPlaces <- OSMfiles[OSMfiles == paste(datdir, './places.shp' , sep = "")] # still needed? only needed if cities need to be points
  dsnPoints <- OSMfiles[OSMfiles == paste(datdir, './points.shp' , sep = "")]
  
  # Read files --------------------------------------------------------------
  infra <- readOGR(dsnInfra, layer = ogrListLayers(dsnInfra))
  places <- readOGR(dsnPlaces, layer = ogrListLayers(dsnPlaces)) # still needed? only needed if cities need to be points
  points <- readOGR(dsnPoints, layer = ogrListLayers(dsnPoints))
  
  # Get start and destination city data -------------------------------------
  placeStartData <- GADM[GADM$NAME_2 == placeStart,] 
  placeDestData <- GADM[GADM$NAME_2 == placeDest,]
  
  # Crop infrastructure to start and destination cities ---------------------
  cropStart <- crop(infra, placeStartData)
  cropDest <- crop(infra, placeDestData)
  
  # Get start and destination coordinates -----------------------------------
  streetStartData <- cropStart[cropStart$name == streetStart,]
  streetDestData <- cropDest[cropDest$name == streetDest,]
  #plot(streetStartData)
  #plot(streetDestData)
  X_MinStart <- bbox(streetStartData)[1,1] # sp package needed for bbox
  Y_MinStart <- bbox(streetStartData)[2,1]
  X_MaxStart <- bbox(streetStartData)[1,2]
  Y_MaxStart <- bbox(streetStartData)[2,2]
  X_Start <- ( 1 / 2) * (X_MinStart + X_MaxStart)
  Y_Start <- ( 1 / 2) * (Y_MinStart + Y_MaxStart)
  coordsdfStart <- data.frame(X_Start, Y_Start)
  
  X_MinDest <- bbox(streetDestData)[1,1] # To do
  Y_MinDest <- bbox(streetDestData)[2,1] # To do
  X_MaxDest <- bbox(streetDestData)[1,2] # To do
  Y_MaxDest <- bbox(streetDestData)[2,2]
  X_Dest <- ( 1 / 2) * (X_MinDest + X_MaxDest)
  Y_Dest <- ( 1 / 2) * (Y_MinDest + Y_MaxDest) # To do
  coordsdfDest <- data.frame(X_Dest, Y_Dest)

  # Create SpatialPointDataFrames of start and destination point ------------
  coordsStart <- SpatialPointsDataFrame(coordsdfStart, coordsdfStart, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL)
  coordsDest <- SpatialPointsDataFrame(coordsdfDest, coordsdfDest, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL)
  
  # Put starting and destination coords on the street
  
  



  
  
  # rasterize
  
}