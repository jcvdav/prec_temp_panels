################################################################################
# title
################################################################################
#
# Juan Carlos Villaseñor-Derbez
# juancvd@stanford.edu
# date
#
# Description
#
################################################################################

## SET UP ######################################################################

# Load packages ----------------------------------------------------------------
pacman::p_load(
  here,
  exactextractr,
  terra,
  sf,
  tidyverse
)

# Load data --------------------------------------------------------------------
comunas <- st_read(dsn = here("raw_data", "Comunas"),
                   layer = "comunas") %>% 
  st_transform(crs = 20048)

precip <- rast(x = here("data", "precipitation_raster_chile.tif")) %>% 
  terra::project(y = "EPSG:20048")

temp <- rast(x = here("data", "temperature_raster_chile.tif")) %>% 
  terra::project(y = "EPSG:20048")

## PROCESSING ##################################################################

# X ----------------------------------------------------------------------------
precip_by_comuna <- exact_extract(precip, y = comunas, fun = "mean", append_cols = T) %>% 
  pivot_longer(cols = contains("mean.precipitation"), names_to = "date", values_to = "precip") %>% 
  mutate(date = str_replace(date, "mean.precipitation_raster_chile", "X."))

temp_by_comuna <- exact_extract(temp, y = comunas, fun = "mean", append_cols = T) %>% 
  pivot_longer(cols = contains("mean.temperature"), names_to = "date", values_to = "temp") %>% 
  mutate(date = str_replace(date, "mean.temperature_raster_chile", "X."))


combined <- left_join(precip_by_comuna, temp_by_comuna,
                      by = join_by(objectid, shape_leng, dis_elec, cir_sena, cod_comuna, codregion, st_area_sh,
                                   st_length_, Region, Comuna, Provincia, date))
