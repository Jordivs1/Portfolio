import requests
import pandas as pd

## Data from the RDW API for license data

def get_license_data(limit):
    url = f"https://opendata.rdw.nl/resource/m9d7-ebf2.json?$limit={limit}"
    response = requests.get(url)
    data1 = response.json()
    df_license = pd.DataFrame(data1)
    return df_license

## Data from the RDW API for fuel types

def get_fuel_data(limit, kentekens):
    kenteken_str = "','".join(kentekens)  #
    where_clause = f"kenteken in('{kenteken_str}')"
    fuel_url = "https://opendata.rdw.nl/resource/8ys7-d773.json?"

    params = {
        '$limit': limit,
        '$where': where_clause
    }

    response = requests.get(fuel_url, params=params)  
    data = response.json()
    df_fuel = pd.DataFrame(data)
    return df_fuel


rdw_license_data = get_license_data(100)

## 1. Welk merk werd het meest toegelaten per jaar? — gebruikt merk en datum_eerste_toelating.
def clean_license_data(df):
    df['datum_eerste_toelating'] = pd.to_datetime(df['datum_eerste_toelating'], errors='coerce') # Convert the 'datum_eerste_toelating' column to datetime format, coercing errors to NaT
    df['toelating_jaar'] = df['datum_eerste_toelating'].dt.year # Extract the year from the 'datum_eerste_toelating' column and create a new column 'toelating_jaar'
    df['merk'] = df['merk'].astype(str) # Convert the 'merk' column to string type
    df['merk'] = df['merk'].str.strip() # Remove leading and trailing whitespace from the 'merk' column
    df['laadvermogen'] = df['laadvermogen'].astype(float) # Convert the 'laadvermogen' column to float, coercing errors to NaN
    return df


rdw_license_data = clean_license_data(rdw_license_data)

def most_admitted_brands_per_year(df):
    most_admitted_brands = df.groupby('toelating_jaar')['merk'].value_counts() # Group the data by 'toelating_jaar' and 'merk', and count the occurrences of each combination
    return most_admitted_brands.groupby('toelating_jaar').head(1) # Return the most admitted brands per year

print(most_admitted_brands_per_year(rdw_license_data)) # Print the most admitted brands per year

## 2. Hoe heeft de brandstofmix van nieuw toegelaten voertuigen zich door de jaren heen ontwikkeld? — vereist de koppeling met de brandstoftabel.
def clean_fuel_data(df):
    df['kenteken'] = df['kenteken'].astype(str) # Convert the 'kenteken' column to string type
    df['brandstof_omschrijving'] = df['brandstof_omschrijving'].astype(str) # Convert the 'brandstof_omschrijving' column to string type
    df['brandstof_omschrijving'] = df['brandstof_omschrijving'].str.strip() # Remove leading and trailing whitespace from the 'brandstof_omschrijving' column
    return df

kentekens = rdw_license_data['kenteken'].unique().tolist()
rdw_fuel_data = get_fuel_data(100, kentekens)
rdw_fuel_data = clean_fuel_data(rdw_fuel_data)

def fuel_mix_over_years(df_license, df_fuel):
    merged_df = pd.merge(df_license, df_fuel, how='inner', left_on='kenteken', right_on='kenteken')
    fuel_mix = merged_df.groupby(['toelating_jaar', 'brandstof_omschrijving']).size().unstack(fill_value=0)
    return fuel_mix

print(fuel_mix_over_years(rdw_license_data, rdw_fuel_data)) # Print the fuel mix over the years

## 3. Wat is de gemiddelde laadcapaciteit (laadvermogen) per voertuigsoort, en welke voertuigsoorten worden het meest toegelaten? — gebruikt voertuigsoort en laadvermogen.
def average_load_capacity_per_vehicle_type(df):
    grouped_data = df.groupby('voertuigsoort')['laadvermogen'].mean().reset_index() # Group the data by 'voertuigsoort' and calculate the mean of 'laadvermogen'
    return grouped_data

print(average_load_capacity_per_vehicle_type(rdw_license_data)) # Print the grouped data with average 'laadvermogen' per 'voertuigsoort'
print(rdw_license_data['voertuigsoort'].value_counts()) # Print the count of each 'voertuigsoort' to see which vehicle types are most admitted

## 4. Hoeveel voertuigen worden jaarlijks geëxporteerd, afgezet tegen het aantal nieuwe toelatingen per jaar? — gebruikt export_indicator en datum_eerste_toelating.
def count_exported_vehicles_per_year(df):
    export_indicator_counts = df[df['export_indicator'] == 'Ja']
    yearly_export = export_indicator_counts.groupby(export_indicator_counts['datum_eerste_toelating'].dt.year)[['export_indicator']].count().reset_index() # Group the data by year and sum the 'export_indicator' to get the number of exported vehicles per year
    return yearly_export

yearly_export = count_exported_vehicles_per_year(rdw_license_data)

def count_new_admissions_per_year(df):
    yearly_new_admissions = df.groupby(df['datum_eerste_toelating'].dt.year)['kenteken'].count().reset_index() # Group the data by year and count the number of new admissions per year
    return yearly_new_admissions

merged_yearly_data = pd.merge(yearly_export, count_new_admissions_per_year(rdw_license_data), how='inner', left_on='datum_eerste_toelating', right_on='datum_eerste_toelating') # Merge the yearly export and new admissions data on the year
print(merged_yearly_data.head()) # Print the merged yearly data with both exported and new admissions per year

## 5. Wat is de gemiddelde "leeftijd" van het huidige wagenpark per voertuigsoort? — gebruikt datum_eerste_toelating en voertuigsoort, vergeleken met de huidige datum.
def avg_age_per_vehicle_type(df):
    df['age_days'] = (pd.Timestamp.now() - df['datum_eerste_toelating']).dt.days # Calculate the age in days for each vehicle by subtracting 'datum_eerste_toelating' from the current date
    average_age = df.groupby('voertuigsoort')['age_days'].mean().reset_index(name='average_age_days') # Group the data by 'voertuigsoort' and calculate the average age in days
    return average_age

print(avg_age_per_vehicle_type(rdw_license_data)) # Print the average age per vehicle type