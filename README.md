# Processing precipitation and temperature data


## Repository structure 

```
-- data
   |__precipitation_panel.csv
   |__temperature_panel.csv
-- docs
   |__1_process_precipitation.Rmd
   |__2_process_temperature.Rmd
   |__3_create_panel.Rmd
-- precip_renato.Rproj
-- raw_data                <<< YOU HAVE TO DOWNLOAD THESE DATA
   |__air_temp.nc
   |__precip_high_res.nc
   |__precip_low_res.nc
-- README.md
-- scripts
   |__download_rasers.R
```

## Set up

If you want to run the code from scratch, you first need to download the raw rasters, which are too big to be shiped around.

Navigate to the `scripts` folder, and run the `download_raster.R` script. This should connect to NOAAs ftp server and download the data. If, for any reason, that fails, you can also manually go to the URLs and download the data. Make sure you save them with the appropriate names and in the appropriate location.

- `raw_data/precip_high_res.nc`: [ftp link](ftp://ftp.cdc.noaa.gov/Datasets/precl/0.5deg/precip.mon.mean.0.5x0.5.nc)

- `raw_data/precip_low_res.nc`: [ftp link](ftp://ftp.cdc.noaa.gov/Datasets/precl/1.0deg/precip.mon.mean.1x1.nc)

- `raw_data/air_temp.nc`: [ftp link](ftp://ftp.cdc.noaa.gov/Datasets/ghcncams/air.mon.mean.nc)

Running the above will be useful if, for example, you want to update the data by the end of the year.

## Data processing

There are three documents containing the data processing. They are all under the `docs` folder. The first document, `1_process_precipitation` shows the downscaling and conversion of raster to data.frame. `2_process_temperature` converts the temperature nc files into a panel. Finally, `3_create_panel` puts these panels together to create a monthly panel of precipitation and temperature for every cell. These data are under `data/precipitation_and_temperature_panel.csv`.

For questions about this, contact juancarlos@ucsb.edu
