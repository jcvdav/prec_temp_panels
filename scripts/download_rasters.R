# download_data

######################################################
## This script connects to the FTP servers and      ##
## dowloads the required rasters into the computer  ##
## you are using. The rasters will be stored in     ##
## the raw_data folder.                             ##
######################################################

# Load packages
library(here)
library(ncdf4)

# Define URLs
## Precipitation high resolution
url_precip_high <- "ftp://ftp.cdc.noaa.gov/Datasets/precl/0.5deg/precip.mon.mean.0.5x0.5.nc"
## Precipitation low resolution
url_precip_low <- "ftp://ftp.cdc.noaa.gov/Datasets/precl/1.0deg/precip.mon.mean.1x1.nc"
## Temperature
url_temp <- "ftp://ftp.cdc.noaa.gov/Datasets/ghcncams/air.mon.mean.nc"

# Download the nc files
download.file(url = url_precip_high,
              destfile = here("raw_data", "precip_high_res.nc"),
              mode = "wb")

download.file(url = url_precip_low,
              destfile = here("raw_data", "precip_low_res.nc"),
              mode = "wb")

download.file(url = url_temp,
              destfile = here("raw_data", "air_temp.nc"),
              mode = "wb")

# END OF SCRIPT
