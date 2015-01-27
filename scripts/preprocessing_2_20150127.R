
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
  X_Start <- coordinates(streetStartData)[[1]][[1]][1,1]
  Y_Start <- coordinates(streetStartData)[[1]][[1]][1,2]
  coordsdfStart <- data.frame(X_Start, Y_Start) # library base needed
  
  X_Dest <- coordinates(streetDestData)[[1]][[1]][1,1]
  Y_Dest <- coordinates(streetDestData)[[1]][[1]][1,2]
  coordsdfDest <- data.frame(X_Dest, Y_Dest)

  # Create SpatialPointDataFrames of start and destination point ------------
  coordsStart <- SpatialPointsDataFrame(coordsdfStart, coordsdfStart, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL) # sp package needed # SpatialPointsDataFrame
  coordsDest <- SpatialPointsDataFrame(coordsdfDest, coordsdfDest, proj4string = CRS(as.character(NA)), match.ID = TRUE, bbox = NULL) # SpatialPointsDataFrame
  
  # Put starting and destination coords on the street -- plot start road and start point
  ##plot(streetStartData)
  ##plot(coordsStart, add = TRUE)
  ##plot dest road and dest point
  ##plot(streetDestData)
  ##plot(coordsDest, add = TRUE)
  
  # Clip to extent of route -------------------------------------------------
  # Define X_Min, Y_Min, X_Max and Y_Max of the start and destination coordinates
  if (X_Start <= X_Dest) {
    X_Min <- X_Start # X_Min instead of XMin, to make sure it does not interfere with functions, same for X_Max, Y_Min and Y_Max
    X_Max <- X_Dest
  } else {
    X_Min <- X_Dest
    X_Max <- X_Start
  }
  
  if (Y_Start <= Y_Dest) {
    Y_Min <- Y_Start
    Y_Max <- Y_Dest
  } else {
    Y_Min <- Y_Dest
    Y_Max <- Y_Start
  }
  
  # Examine the boundaries for the clipbox for x and y
  X_MaxExtentTemp <- X_Max + (1 / 5 * (X_Max - X_Min))
  Y_MaxExtentTemp <- Y_Max + (1 / 5 * (Y_Max - Y_Min))
  
  if (abs(X_MaxExtentTemp - X_Max) <= abs(Y_MaxExtentTemp - Y_Max)) {
    extentValue <- abs(Y_MaxExtentTemp - Y_Max)
  } else {
    extentValue <- abs(X_MaxExtentTemp - X_Max)
  }
  
  X_MinExtent <- X_Min - extentValue
  Y_MinExtent <- Y_Min -  (2/3) * extentValue
  X_MaxExtent <- X_Max + extentValue
  Y_MaxExtent <- Y_Max +  (2/3) *  extentValue
                          
  # Define extent of clipbox of the route
  extentRoute <- extent(X_MinExtent, X_MaxExtent, Y_MinExtent, Y_MaxExtent)
  
  # Clip infrastucture data to extent of route
  infraClip <- crop(infra, extentRoute)
  # plot to check data
  plot(infraClip) ### plotten voor presentatie
  plot(coordsStart, add = TRUE, col = "red") ### plotten voor presentatie
  plot(coordsDest, add = TRUE, col = "orange") ### plotten voor presentatie
  
  
  
}