import vertexai
import streamlit as st
import requests, os 
import pandas as pd
import json 
import geopandas as gpd


from langchain.llms import VertexAI
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory
from langchain.agents import create_pandas_dataframe_agent, AgentType
from langchain.memory import ConversationBufferMemory
from langchain.tools import Tool
from langchain.output_parsers import CommaSeparatedListOutputParser


credential = "/workspaces/project_open_hackathons/secretes/fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path
os.environ["GPLACES_API_KEY"] = './secretes/map_api_key.txt'


PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)




st.title("🌿🌿Green man☘️☘️")

st.chat_message("ai").write('What can I help you?')

model_selectbox = st.selectbox(
    'Choose a model',
    ('text-bison@001-Vertex AI', 'text-bison@001-Generative AI'))
    

def LLM_init():
    template = """The following is set of summaries:
        You have some bus stop geojson file. 
        You must list the location and Google Maps url of each bus stop.
        Take these and distill it into a final, consolidated summary of the main themes. 
        If you don't know, please say I don't know.
        {chat_history}
        Human: {human_input}
        Helpful Answer:
        """
    prompt_for_llm = PromptTemplate(template=template, input_variables=["chat_history","human_input"])
    memory = ConversationBufferMemory(memory_key="chat_history")
    vertex_ai_model = VertexAI()
    
    llm_chain = LLMChain(
        prompt=prompt_for_llm, 
        llm=vertex_ai_model, 
        memory=memory, 
        verbose=True)
    
    return llm_chain

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
        
        path = './data/bus.geojson'
        bus = gpd.read_file(path)
        
        llm_chain = LLM_init()
        vertex_ai_model = VertexAI(
            model_name='text-bison-32k',
            llm_chain=llm_chain,
            max_output_tokens=800,
            temperature=0.3,
            top_p=0.8,
            top_k=40
        )

        agent = create_pandas_dataframe_agent(vertex_ai_model, bus, verbose=True)
        response = agent.run(prompt)
        output_parser = CommaSeparatedListOutputParser()
        output = output_parser.parse(response)
    
        with st.chat_message("assistant"):
            st.markdown(output)
        st.session_state.messages.append({"role": "ai", "content": output})
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
            temperature=0.2,
            top_p=0.8,
            top_k=40
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
