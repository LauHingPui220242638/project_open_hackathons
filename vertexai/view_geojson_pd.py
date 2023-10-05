import json
import pandas as pd
import os
import vertexai

from pandas_geojson import read_geojson_url, filter_geojson
from langchain.document_loaders import JSONLoader
from langchain.chains import RetrievalQA
from langchain.embeddings.vertexai import VertexAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import Chroma

from llm import LLM_init

credential = "fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)



gmb_geojson = read_geojson_url('https://static.data.gov.hk/td/routes-fares-geojson/JSON_GMB.json')
filter = ['Cyberport']
gmb_output = filter_geojson(geo_json=gmb_geojson,filter_list=filter,property_key='locStartNameE')

gmb_pd = pd.read_json(open(gmb_output))
#gmb_pd = pd.concat(map(pd.read_json, gmb_geojson))

j = JSONLoader(file_path=gmb_pd,jq_schema='.coordinates[]',text_content=False)

json_loader = j.load()
gmb = pd.DataFrame(json_loader)

text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
documents = text_splitter.split_documents(gmb)
llm_chain = LLM_init()

db = Chroma.from_documents(documents, VertexAIEmbeddings())
qa = RetrievalQA.from_chain_type(llm_chain, chain_type="stuff", retriever=db.as_retriever())
qa.run('Where is Cyberport ?')
