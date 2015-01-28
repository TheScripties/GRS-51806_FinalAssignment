"""
Created on Mon January 26 2015
Route planner for heavy transport.
@authors: Michiel Blok and Madeleine van Winkel
"""

# Import packages ### instal if needed
if (!require(base)){print("base package is not installed. Installing it now.");install.packages(base, dependencies = TRUE)} # install base package
if (!require(graphics)){print("graphics package is not installed. Installing it now.");install.packages(graphics, dependencies = TRUE)} # install graphics package
if (!require(downloader)){print("downloader package is not installed. Installing it now.");install.packages(downloader, dependencies = TRUE)} # install downloader package
if (!require(rgdal)){print("rgdal package is not installed. Installing it now.");install.packages(rgdal, dependencies = TRUE)} # install rgdal package
if (!require(raster)){print("raster package is not installed. Installing it now.");install.packages(raster, dependencies = TRUE)} # install raster package
if (!require(sp)){print("Sp package is not installed. Installing it now.");install.packages(sp, dependencies = TRUE)} # install sp package
###if (!require(utils)){print("utils package is not installed. Installing it now.");install.packages(utils, dependencies = TRUE)} # install sp package # not used as of yet

library(base)
library(downloader)
library(graphics) # wss nodig voor plot
library(rgdal)
library(raster)
library(sp)
###library(utils) # not used as of yet

#library(Shiny)
#library(rPython)

# Source functions
source('scripts/preprocessing.R') ### error?!

# Then the actual commands
preprocessing()
