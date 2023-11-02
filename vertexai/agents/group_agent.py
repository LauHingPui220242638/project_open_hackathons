import pandas as pd
import vertexai
import os
import geopandas as gpd

from langchain.llms import VertexAI
from langchain.agents import initialize_agent, create_pandas_dataframe_agent, AgentType
from langchain.tools import GooglePlacesTool, Tool
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory


credential = "/workspaces/project_open_hackathons/secretes/fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)




def LLM_init():
    template = """
    You have some bus or ferry or minibus stop geojson file. 
    You must list the location and Google Maps url of each bus or ferry or minibus stop stop.
    {chat_history}
        Human: {human_input}
        Chatbot:"""
    

    prompt_for_llm = PromptTemplate(template=template, input_variables=["chat_history","human_input"])
    memory = ConversationBufferMemory(memory_key="chat_history")
    vertex_ai_model = VertexAI()

    llm_chain = LLMChain(
        prompt=prompt_for_llm, 
        llm=vertex_ai_model, 
        memory=memory, 
        verbose=True
            )
    return llm_chain


def bus_agent():
  
    path = './vertexai/data/bus.geojson'
    
    bus = gpd.read_file(path)
    
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.8,
        top_k=40
    )
    agent = create_pandas_dataframe_agent(vertex_ai_model, bus, verbose=True)
    result = agent.run('Please describe the coordinates and Google URL of 5 location. It needs to be expressed in complete sentences.')    
    return result
    
def ferry_agent():
    path = './vertexai/data/ferry.geojson'
    
    ferry = gpd.read_file(path)
    
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.8,
        top_k=40
    )
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, ferry, verbose=True)
    result = agent.run('Please describe the coordinates and Google URL of 5 location. It needs to be expressed in complete sentences.')
    return result
    
def minibus_agent():
    path = './vertexai/data/minibus.geojson'
    
    minibus = gpd.read_file(path)
    
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.8,
        top_k=40
    )
    agent = create_pandas_dataframe_agent(vertex_ai_model, minibus, verbose=True)
    result = agent.run('Please describe the coordinates and Google URL of 5 location. It needs to be expressed in complete sentences.')
    return result
    
def vertexai_agent():
    
    llm_chain = LLM_init()

