import os
import vertexai
import geopandas as gpd

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
    You have about mtr station geojson file. 
    You must find out name, coordinates and google_map_url of each mtr station data, then query the data.
    {chat_history}
        Human: {human_input}
        Chatbot:"""

    prompt_for_llm = PromptTemplate(template=template, input_variables=["chat_history","human_input"])
    memory = ConversationBufferMemory(memory_key="chat_history")
    llm = VertexAI(model_name="text-bison-32k")

    llm_chain = LLMChain(
        prompt=prompt_for_llm, 
        llm=llm, 
        memory=memory, 
        verbose=True
    )
    return llm_chain



def mtr_agent():
    file_path = './data/mtr.geojson'
    data = gpd.read_file(file_path)
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        llm_chain=llm_chain,
        max_output_tokens=256,
        temperature=0.1,
        top_p=0.2,
    )
    
    agent = create_pandas_dataframe_agent(
        vertex_ai_model,
        data,
        max_iterations=10,
        max_execution_time=50,
        verbose=True
    )
    result = agent.run('List data')
    return result
    
    
print(mtr_agent())
