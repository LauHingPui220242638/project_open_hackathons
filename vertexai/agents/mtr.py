import json
import os
import vertexai
import geopandas as gpd
from pathlib import Path

from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory


credential = "/workspaces/project_open_hackathons/secretes/shaped-storm-401909-adaff701b395.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


def LLM_init():
    template = """
    You have about bus station geojson file. 
    You must find the location and Google Maps url of each bus station.
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


def mtr_agent():

    file_path = './data/bus.geojson'

    data = gpd.read_file(file_path)
    
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=1000,
        temperature=0.1,
        top_p=0.3
    )
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, data, verbose=True,)

    result = agent.run("Where are mtr? Give me three option.")
    return result

#path_dict = './data/bus.geojson', './data/ferry.geojson'
#good = mtr_agent(path = path_dict)
print(mtr_agent())
