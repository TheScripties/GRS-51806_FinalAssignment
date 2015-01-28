"""
Created on Mon January 26 2015
Route planner for heavy transport.
@authors: Michiel Blok and Madeleine van Winkel
"""
# Import packages ### instal if needed
if (!require(base)){print("base package is not installed. Installing it now.");install.packages(base, dependencies = TRUE)} # install base package
if (!require(downloader)){print("downloader package is not installed. Installing it now.");install.packages(downloader, dependencies = TRUE)} # install downloader package
if (!require(rgdal)){print("rgdal package is not installed. Installing it now.");install.packages(rgdal, dependencies = TRUE)} # install rgdal package
if (!require(raster)){print("raster package is not installed. Installing it now.");install.packages(raster, dependencies = TRUE)} # install raster package
if (!require(sp)){print("sp package is not installed. Installing it now.");install.packages(sp, dependencies = TRUE)} # install sp package
#if (!require(Shiny)){print("Shiny package is not installed. Installing it now.");install.packages(Shiny, dependencies = TRUE)} # install Shiny package
#if (!require(rPython)){print("rPython package is not installed. Installing it now.");install.packages(rPython, dependencies = TRUE)} # install rPython package

library(base)
library(downloader)
library(rgdal)
library(raster)
library(sp)
#library(Shiny)
#library(rPython)

# Source functions
source('scripts/preprocessing.R')

# Then the actual commands
preprocessing()
