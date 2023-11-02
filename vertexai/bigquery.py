# streamlit_app.py

import streamlit as st
from google.oauth2 import service_account
from google.cloud import bigquery

# Create API client.
credentials = service_account.Credentials.from_service_account_info(
    st.secrets["gcp_service_account"]
)
client = bigquery.Client(credentials=credentials)

# Perform query.
# Uses st.cache_data to only rerun when the query changes or after 10 min.
@st.cache_data(ttl=600)
def run_query(query):
    query_job = client.query(query)
    rows_raw = query_job.result()
    # Convert to list of dicts. Required for st.cache_data to hash the return value.
    rows = [dict(row) for row in rows_raw]
    return rows

# Query data from BigQuery.
rows = run_query("SELECT * FROM `fyp-open-data-hackathon.test.test` LIMIT 30")

# Print results.
st.write("Get data from BigQuery:")
for row in rows:
    # Print columns specifying which column.
    st.write("✍️ " + row["Control_Point"] + " - " + str(row["Total"]))