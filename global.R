
# to load shiny
library(shiny)
library(shinydashboard)
library(shinythemes)

# library package for data wrangling both datfram and spatial
library(dplyr)
library(spdplyr)
library(geojsonio)
library(geojsonsf)
library(scales)

#library package for visualization
library(mapdeck)
library(plotly)
library(ggplot2)
library(glue)


#API CALL FOR MAPBOX
key <- 'pk.eyJ1IjoiaGFyZHlzZXR5b3NvIiwiYSI6ImNrZXV6NTF0czFrZGQyeG4wNDVvZnczODgifQ.oy-_jwdY5W6PeQeUuo-6CQ'

#DATA CALLING
nyc_airbnb <- readRDS("nyc_airbnb.rds")
nycairbnb_count_geojson <- readRDS("nycairbnb_count_geojson.rds")
circle <- readRDS("circle.rds")
nyc3d = 'https://tiles.arcgis.com/tiles/z2tnIkrLQ2BRzr6P/arcgis/rest/services/New_York_LoD2_3D_Buildings/SceneServer/layers/0'

#DATA WRANGLING FOR DUMBEL PLOT
df <- nyc_airbnb %>%
	group_by(neighbourhood_group, neighbourhood, room_type) %>%
	summarise(min = min(price),
						max = max(price)) %>%
	ungroup()

draw_base_map <- function(){

	mapdeck(
		token = key,
		width = 700,
		height = 700,
		style = "mapbox://styles/mapbox/dark-v10",
		pitch = 50,
		bearing = 25,
		zoom = 10,
		location =c(-73.99701041459296,40.716870845525336))

}

update_map <- function(mapdeck, sf, v) {

	m <- mapdeck_update(map_id = mapdeck)

	if ( v == "Hexagon" ) {

		m %>%
			clear_polygon(layer_id = "3D Choropleth") %>%
			clear_scatterplot(layer_id = "Scatterplot") %>%
			clear_scatterplot(layer_id = "Proportional Symbol") %>%
			add_hexagon(
				data = nyc_airbnb,
				lat = "latitude",
				lon = "longitude",
				radius = 200,
				elevation_scale = 5,
				layer_id = "Hexagon",
				update_view = FALSE
			)


	}	else if ( v == "3D Choropleth"){
		m %>%
			clear_hexagon(layer_id = "Hexagon") %>%
			clear_scatterplot(layer_id = "Scatterplot") %>%
			clear_scatterplot(layer_id = "Proportional Symbol") %>%
			add_polygon(
				data = nycairbnb_count_geojson,
				fill_colour = "zone",
				elevation = "scale",
				update_view = FALSE,
				tooltip = "info",
				layer_id = "3D Choropleth"
			)

	} else if ( v == "Proportional Symbol"){
		m %>%
			clear_polygon(layer_id = "3D Choropleth") %>%
			clear_hexagon(layer_id = "Hexagon") %>%
			clear_scatterplot(layer_id = "Scatterplot") %>%
			add_scatterplot(
				data = circle,
				lat = "latitude_",
				lon = "longitude_",
				radius = "radius",
				fill_colour = "neighbourhood",
				tooltip = "tooltip",
				auto_highlight = TRUE,
				layer_id = "Proportional Symbol",
				update_view = FALSE

			)

	} else{
		m %>%
			clear_hexagon(layer_id = "Hexagon") %>%
			clear_polygon(layer_id = "3D Choropleth") %>%
			clear_scatterplot(layer_id = "Proportional Symbol") %>%
			add_scatterplot(
				data = nyc_airbnb,
				lat = "latitude",
				lon = "longitude",
				update_view = FALSE,
				radius = 10,
				layer_id = "Scatterplot",
				fill_colour = "neighbourhood",
				tooltip = "tooltip_price"

			)


	}
}
