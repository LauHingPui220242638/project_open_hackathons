import vertexai
import os
import geopandas as gpd

from langchain.embeddings import VertexAIEmbeddings

credential = "/workspaces/project_open_hackathons/secretes/fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path

PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)


bus = gpd.read_file('https://static.data.gov.hk/td/routes-fares-geojson/JSON_GMB.json', rows=20)
bus_queries = bus[bus.geometry, bus.locStartNameE, bus.stopNameE]

agent = VertexAIEmbeddings(bus_queries, verbose=True)


print(agent)
