# NavigatoR main script for calculating and plotting distance between 2 locations within the Netherlands.
# Authors: Michiel Blok and Madeleine van Winkel
# Created on Monday January 26 2015
## Description:
## This is the main script for the NavigatoR. 
## This script will check whether packages need to be installed, and will install these packages if needed. It will also load the required packages.
## Afterwards, the source functios are created and defaults are given to try out the script.
## Finally, the functions that this programs exists of are called and runned.
## The authors wish you a lot of fun with the NavigatoR!


# Import packages ---------------------------------------------------------
# Install packages if needed
if (!require(utils)){print("utils package is not installed. Installing it now.");install.packages("utils", dependencies = TRUE)}
if (!require(base)){print("base package is not installed. Installing it now.");install.packages("base", dependencies = TRUE)}
if (!require(graphics)){print("graphics package is not installed. Installing it now.");install.packages("graphics", dependencies = TRUE)}
if (!require(downloader)){print("downloader package is not installed. Installing it now.");install.packages("downloader", dependencies = TRUE)}
if (!require(plotKML)){print("plotKML package is not installed. Installing it now.");install.packages("plotKML", dependencies = TRUE)}
if (!require(raster)){print("raster package is not installed. Installing it now.");install.packages("raster", dependencies = TRUE)}
if (!require(rgdal)){print("rgdal package is not installed. Installing it now.");install.packages("rgdal", dependencies = TRUE)}
if (!require(rgeos)){print("geos package is not installed. Installing it now.");install.packages("rgeos", dependencies = TRUE)}
if (!require(sp)){print("Sp package is not installed. Installing it now.");install.packages("sp", dependencies = TRUE)}

# Load packages
library(utils)
library(base)
library(downloader)
library(graphics)
library(plotKML)
library(raster)
library(rgdal)
library(rgeos)
library(sp)

# Source functions --------------------------------------------------------
source('R/01_preprocessing.R')
source('R/02_calculation.R')
source('R/03_visualization.R')

# Defaults for places and streets -----------------------------------------
placeStart = "Rotterdam"
streetStart = "Gordelweg"
placeDest = "Capelle aan den IJssel"
streetDest = "Slotlaan"

# Actual commands ---------------------------------------------------------
navigatoR.coords <- preprocessing (placeStart, streetStart, placeDest, streetDest)
navigatoR.calculation <- calculation (navigatoR.coords)
visualization(navigatoR.coords, navigatoR.calculation)