Business Hour Mismatch Analysis
Overview
This project analyzes the impact of business hour mismatches between Grubhub and UberEats for restaurants. The goal is to identify discrepancies in business hours listed on these two platforms, which can affect operational consistency.

The analysis includes:

Extracting and normalizing business hour data from Grubhub and UberEats.
Computing the business hour mismatch metric.
Categorizing the mismatch into predefined ranges.
Data Sources
UberEats
Table: arboreal-vision-339901.take_home_v2.virtual_kitchen_ubereats_hours
Data: Contains business hours in JSON format, including daysBitArray and regularHours.
Grubhub
Table: arboreal-vision-339901.take_home_v2.virtual_kitchen_grubhub_hours
Data: Contains business hours in JSON format under the response field.
Setup Instructions
Access BigQuery Console:

Open your BigQuery Console.
Run SQL Queries:

Use the SQL queries provided below to extract, normalize, and compare business hours data from both platforms.