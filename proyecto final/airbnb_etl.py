import pandas as pd
import numpy as np

import psycopg2
from sqlalchemy import create_engine

# Importamos el dataset de los datos de Airbnb (Extract)
df = pd.read_csv("airbnb-listings.csv", delimiter=";")


#seleccionamos las columnas que nos servirán para realizar el análisis (Transform)
df_madrid = df.filter(["Host Total Listing", "Street", "Neighbourhood Group Cleansed","City", "State", "Zipcode", "Smart Location","Country Code","Latitude", "Longitude", "Property Type", "Room Type","Accommodates", "Bathrooms", "Bedrooms", "Beds", "Bed Type", "Amenities", "Price", "Security Deposit", "Cleaning Fee", "Guests Included", "Extra People", "Minimum Nights", "Maximum Nights", "Number of Reviews", "Review Scores Rating", "Cancellation Policy", "Reviews per Month"],axis=1)

#eliminamos las filas que NO tengan "City==Madrid and City==Delicias-Madrid", así me solo quedan las correspondientes a madrid
#faltar ver como incluir las palabras "mal escritas",normalizar estos datos

df_airbnb_madrid = df_madrid[df_madrid["City"] == "Madrid"]

#Lo cargamos a la base de datos (postgress)(load)

engine = create_engine('postgresql://gaby:@localhost:5432/proyecto_final')
df_airbnb_madrid.to_sql('airbnb_list', engine)