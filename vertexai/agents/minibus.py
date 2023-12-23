import vertexai
import os
import geopandas as gpd


from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain.agents.agent_types import AgentType
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory
from langchain.output_parsers import StructuredOutputParser
from langchain.output_parsers import ResponseSchema


credential = "/workspaces/project_open_hackathons/secretes/shaped-storm-401909-adaff701b395.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path
os.environ["GPLACES_API_KEY"] = 'AIzaSyCo61iv0OhiYL7yRwKrTaAuFCh2lsDekPc'

PROJECT_ID = 'shaped-storm-401909'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)



def LLM_init():
    template = """
    You have some about minibus and ferry data for geojson file. 
    You must list the location start name or end name or Google Maps url of each minibus stop.
    {chat_history}
        Human: {human_input}
        Chatbot:
    """

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


def minibus_agent():
    path = './data/minibus.geojson'
    minibus = gpd.read_file(path)
        
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.4
    )
    agent = create_pandas_dataframe_agent(vertex_ai_model, minibus, verbose=True,max_execution_time=10,)
    result = agent.run('Please list the locStartNameE and coordinates of 5 minibus stops')
    return result


def ferry_agent():
    path = './data/ferry.geojson'
    ferry = gpd.read_file(path) 
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.4
    )
    agent = create_pandas_dataframe_agent(vertex_ai_model, ferry, verbose=True,max_execution_time=10,)
    result = agent.run('Please list the locStartNameE, coordinates and google map url of 5 ferry stops')
    return result


minibus_agent_data = minibus_agent()
ferry_agent_data = ferry_agent()


def run_and_compare_queries(minibus, ferry, query: str):
    query_template = f"{query}"

    result1 = minibus(query_template)
    result2 = ferry(query_template)

prompt = "Please give me coordinates for 1 ferry stops and 1 minibus stops."
run_and_compare_queries(minibus=minibus_agent_data, ferry=ferry_agent_data, query=prompt)
print(minibus_agent_data)