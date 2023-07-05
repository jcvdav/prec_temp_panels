# Load packages ----------------------------------------------------------------
pacman::p_load(
  here,
  lubridate,
  exactextractr,
  raster,
  sf,
  tidyverse
)

# Load data --------------------------------------------------------------------
comunas <- st_read(dsn = here("raw_data", "Comunas"),
                   layer = "comunas") %>% 
  st_transform(crs = 20048)

precip <- brick(x = here("raw_data", "precip_high_res.nc")) %>% 
  rotate() %>% 
  projectRaster(crs = 20048)

temp <- brick(x = here("raw_data", "air_temp.nc")) %>% 
  rotate() %>% 
  projectRaster(crs = 20048)

## PROCESSING ##################################################################

# X ----------------------------------------------------------------------------
precip_by_comuna <- exact_extract(precip, y = comunas, fun = "mean", append_cols = T) %>% 
  pivot_longer(cols = contains("mean.X"), names_to = "date", values_to = "precip")

temp_by_comuna <- exact_extract(temp, y = comunas, fun = "mean", append_cols = T) %>% 
  pivot_longer(cols = contains("mean.X"), names_to = "date", values_to = "temp")

combined <- left_join(precip_by_comuna, temp_by_comuna,
                      by = join_by(objectid, shape_leng, dis_elec, cir_sena, cod_comuna, codregion, st_area_sh,
                                   st_length_, Region, Comuna, Provincia, date)) %>% 
  mutate(date = str_remove(date, "mean.X"),
         date = ymd(date))
