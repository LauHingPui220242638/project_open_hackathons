import vertexai
import streamlit as st
import requests, os 
import pandas as pd

from langchain.llms import VertexAI
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory
from langchain.agents import create_pandas_dataframe_agent, create_csv_agent, AgentType
from langchain.callbacks import StreamlitCallbackHandler
from vertexai.language_models import TextGenerationModel
from langchain.memory import ConversationBufferMemory
from langchain.memory.chat_message_histories import StreamlitChatMessageHistory
from langchain.tools import BaseTool, Tool
from langchain.utilities import SerpAPIWrapper
from langchain.document_loaders import JSONLoader

from jsondownload import jsonDownload

from pandas_geojson import read_geojson_url, read_geojson, filter_geojson

from llm import LLM_init

credential = "fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)



st.title("🌿🌿Green man☘️☘️")

st.chat_message("ai").write('What can I help you?')


model_selectbox = st.selectbox(
    'Choose a model',
    ('text-bison@001-Vertex AI', 'text-bison@001-Generative AI'))


def message_session():
    if "messages" not in st.session_state:
        st.session_state.messages = []
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])
    return message_session



def vertexai_function():
    if prompt := st.chat_input("Talk to Vertex AI on Green man"):
        st.session_state.messages.append({"role": "user", "content": prompt})
        st.chat_message("user").markdown(prompt)
        llm_chain = LLM_init()
        gmb_geojson = read_geojson_url('https://static.data.gov.hk/td/routes-fares-geojson/JSON_GMB.json')
        filter = ['Cyberport']
        gmb_output = filter_geojson(geo_json=gmb_geojson,
                                    filter_list=filter,
                                    property_key='locStartNameE')
        gmb_pd = pd.read_json(gmb_output)
        loader = JSONLoader(file_path=gmb_geojson,jq_schema='.[].Cyberport',text_content=False).load()
        gmb = pd.DataFrame(loader)

        agent = create_pandas_dataframe_agent(llm_chain, gmb, verbose=True)
        response = agent.run(prompt)
        with st.chat_message("assistant"):
            st.markdown(response)
        st.session_state.messages.append({"role": "ai", "content": response})
        
    return vertexai_function


def generationai_function():
    if "messages" not in st.session_state:
        st.session_state.messages = []

    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])
    
    if prompt := st.chat_input("Talk to Generative AI on Green man"):
        st.session_state.messages.append({"role": "user", "content": prompt})
        st.chat_message("user").markdown(prompt)
        generation = generation_model.predict(
            prompt=prompt,
            max_output_tokens=256,
            temperature=0,
        ).text
        with st.chat_message("assistant"):
            st.markdown(generation)
        st.session_state.messages.append({"role": "ai", "content": generation})
    return generationai_function



if model_selectbox == 'text-bison@001-Vertex AI':
    model_name = "text-bison@001"
    message_session()
    vertexai_function()


elif model_selectbox == 'text-bison@001-Generative AI':
    generation_model = TextGenerationModel.from_pretrained("text-bison@001")
    generationai_function()


