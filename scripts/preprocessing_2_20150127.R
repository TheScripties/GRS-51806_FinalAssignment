
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
  #download(url = "http://download.geofabrik.de/europe/netherlands-latest.shp.zip" , destfile = "data/netherlands-latest.shp.zip", quiet = TRUE, method = "auto")  
  #OSMfiles <- unzip(zipfile = paste(datdir, "/netherlands-latest.shp.zip", sep = "") , exdir = paste(datdir, ".", sep = "") , overwrite = TRUE) 
  GADM <- raster::getData("GADM", country = "NLD", level = 2, path = "data")
  
  # Reference to the files --------------------------------------------------
  #dsnInfra <- OSMfiles[OSMfiles == paste(datdir, '/roads.shp' , sep = ".")] ### package needed?!  ### No longer working :(
  #dsnPlaces <- OSMfiles[OSMfiles == paste(datdir, './places.shp' , sep = "")] # still needed? only needed if cities need to be points
  #dsnPoints <- OSMfiles[OSMfiles == paste(datdir, '/points.shp' , sep = ".")] ### package needed?!  ### No longer working :(
  
  # Read files --------------------------------------------------------------
  #infra <- readOGR(dsnInfra, layer = ogrListLayers(dsnInfra)) ### No longer working :(
  infra <- readOGR("data/roads.shp", layer = ogrListLayers("data/roads.shp"))
  #places <- readOGR(dsnPlaces, layer = ogrListLayers(dsnPlaces)) # still needed? only needed if cities need to be points
  #points <- readOGR(dsnPoints, layer = ogrListLayers(dsnPoints)) ### No longer working :(
  points <- readOGR("data/points.shp", layer = ogrListLayers("data/points.shp"))
  
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
  
  
  # Clip infrastucture data and point data to extent of route
  infraClip <- crop(infra, extentRoute)
  pointsClip <- crop(points, extentRoute)
  # save as shapefile TEMP, DELETE for final project!
  shapefile(infraClip, filename='data/infraClip.shp', overwrite = TRUE) ### DELETE this and comment above for final project!
  # plot to check data

  # Perform Dijkstra's algorithm --------------------------------------------
  # Get crossings of streets
  crossings <- pointsClip[pointsClip@data$type == "crossing",] ### wss niet meer nodig
  # plot(crossings, add = TRUE, col = "green")
  ## stations <- pointsClip[pointsClip@data$type == "station",]
  ## plot(stations, add = TRUE, col = "blue")
  # motorwayJunctions <- pointsClip[pointsClip@data$type == "motorway_junctio",]
  # plot(motorwayJunctions, add = TRUE, col = "purple")
  
  # a <- unique(pointsClip@data$type, incomparables = FALSE)
  # a


  # Create route from start to destination ----------------------------------
  # Create dataframe to keep track of coords of where the route touches other roads (nodes)
  coordsStartMatrix <- matrix(coordinates(coordsStart), ncol = 2)
  coordsSDestMatrix <- matrix(coordinates(coordsDest), ncol = 2)
  coordsRoute <- coordsStartMatrix ### data.frame(X_Start, Y_Start) or matrix(X_Start, Y_Start, )
  coordsRouteTemp <- coordsStartMatrix
  # Create a while loop to continue until destination is reached or until no closer coords are found
  while (coordsRouteTemp != coordsDestMatrix) {
    # Get the coords of the nodes of the current road
    getCoordsNodesOnLines and create matrix of the coords of the road (lineSegment) ### Madeleine's for-loop (see vertexPoints)
    vertexPoints <- c(X_onLine, Y_onLine)    
    for(i in 1:length(coordinates(infraClip))) { #i = 1 # --> for- loop met for(i in 1:length(coordinates(streetStartData)))
      for(j in 1:length(coordinates(infraClip)[[i]])){ #j = 1 # --> altijd 1 --- for(j in 1:length(coordinates(streetStartData)[[45]]))
        for(k in 1:length(coordinates(infraClip)[[i]][[j]][k,])){ #k = 1 # unclear -- for(k in 1:length(coordinates(streetStartData)[[45]][[1]]))
          vertexPoints <- c(vertexPoints, coordinates(infraClip)[[i]][[j]][k,]) ###
          matrixVertexPoints <- matrix(vertexPoints, ncol = 2) ### create matrix, 1st column = x, 2nd column = y --- to create coords out of these columns ### ncol = 2 ### nrow = rowsVPS --> niet meer nodig met ncol = 2
          #rowsVPS <- rowsVPS 1 ### --> niet meer nodig met ncol = 2
        }
      }
    }
      # Add coords of node to the route if they are closer to the destination
      if(check whether nodes of the road are closer to coordsDestMatrix) {
        coordsTemp <- coords
        coordsRoute <- coordsROute + coordsTemp
      }
    # Add the destination coordinates if there are no more nodes closer to the destination
    if (noCoordsMoreNearDest){
      coordsRoute += coordsDest
    }
  }
  ## punten uit de matrix omzetten naar SpatialPointsDataFrame met SpatialPointsDataFrame(...)?!
  

  # Calculate distance from start to destination ----------------------------
  startToDestM <- pointDistance(coordsStart, coordsDest, lonlat = TRUE, allpairs = TRUE)
  startToDestKm <- startToDestM / 1000

  # Visualization -----------------------------------------------------------
  plot(infraClip) ### plotten voor presentatie
  plot(coordsStart, add = TRUE, col = "red") ### plotten voor presentatie
  plot(coordsDest, add = TRUE, col = "orange") ### plotten voor presentatie
  # add startToDestKm as legend (distance between start and destination)
  # add labels for start and destination point
  
  #kies segments, of een van de arrows als lijn/ arrow tussen punten voor de presentatie
  segments(X_Start, Y_Start, X_Dest, Y_Dest, col = "purple")
  arrows(X_Start, Y_Start, X_Dest, Y_Dest, col = "blue")
  arrows(X_Start, Y_Start, X_Dest, Y_Dest, col = "blue", lwd = 10) # dikke pijl, waarbij je de begin en eindpunten niet meer ziet
  
  # voor presentatie: het zou tof zijn als we een (Spatial)Line(DataFrame) zouten kunnen maken, want dan zouden we er ook een bewegd plaatje van kunnen maken
  # exporteren naar KML?
  
}

#Names everywhere?
#Add data folder to github
#remove Dijkstras algorithm from scripts folder
#Clean code
#Comments
#Create different functions
