import pandas as pd
import vertexai
import os
import geopandas as gpd
import json
import requests

from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain.tools import GooglePlacesTool, Tool
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory



credential = "/workspaces/project_open_hackathons/secretes/fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path
os.environ["GPLACES_API_KEY"] = './secretes/map_api_key.txt'

PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)



def LLM_init():
    template = """
    You have some ferry stop geojson file. 
    You must list the location and Google Maps url of each ferry stop.
    Here is the output json structure example: 'response_data = {{\"coordinates\":[123.4,321.5,122.34]}}'
    Only return the coordinates in the json structure.
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
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, ferry, verbose=True,)
    result = agent.run('Please list on coordinates of 1 ferry stops.')

    return result

agent_ferry = ferry_agent()






test_data_json_en = json.loads(agent_ferry.encode('utf-8'))

start = test_data_json_en['data'][0]['coordinates']


print(start)
print(type(start))
#print(test_data_json_en['coordinates'])
