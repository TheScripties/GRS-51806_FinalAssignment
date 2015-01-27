"""
Created on Mon January 26 2015
Route planner for heavy transport.
@authors: Michiel Blok and Madeleine van Winkel
"""

processing <- function() { # arguments: city, street
  datdir <- 'data'

  # Download and unzip the data ---------------------------------------------
  #download(url = "http://download.geofabrik.de/europe/netherlands-latest.shp.zip" , destfile = "data/netherlands-latest.shp.zip", quiet = TRUE, method = "auto")  
  #OSMfiles <- unzip(zipfile = paste(datdir, "/netherlands-latest.shp.zip", sep = "") , exdir = paste(datdir, ".", sep = "") , overwrite = TRUE)
  GADM <- raster::getData("GADM", country = "NLD", level = 2, path = "data")
  
  # Reference to the files --------------------------------------------------
  dsnInfra <- OSMfiles[OSMfiles == paste(datdir, './roads_Clip.shp' , sep = "")]
  dsnPlaces <- OSMfiles[OSMfiles == paste(datdir, './places_Clip.shp' , sep = "")]
  
  # Read files --------------------------------------------------------------
  infra <- readOGR(dsnInfra, layer = ogrListLayers(dsnInfra))
  places <- readOGR(dsnPlaces, layer = ogrListLayers(dsnPlaces))
  
  # Temp clip for faster processing --- DELETE for final project!
  GADM$NAME_1 == "Zuid-Holland"
  #infra.clip <- clip(infra, GADM$NAME_1 == "Zuid-Holland")
  #places.clip <- clip(places, GADM$NAME_1[GADM$NAME_1 == "Zuid-Holland"])

  # raster package --> extent
  # methods --> getExtends


  # Delete level-crossings --------------------------------------------------
  
  return()
}


