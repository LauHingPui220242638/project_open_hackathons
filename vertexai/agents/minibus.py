import vertexai
import os
import geopandas as gpd


from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain.agents.agent_types import AgentType
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory



credential = "/workspaces/project_open_hackathons/secretes/fyp-open-data-hackathon-7fccdf48c91c.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path
os.environ["GPLACES_API_KEY"] = 'AIzaSyCo61iv0OhiYL7yRwKrTaAuFCh2lsDekPc'

PROJECT_ID = 'fyp-open-data-hackathon'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)



def LLM_init():
    template = """
    You have some minibus stop geojson file. 
    You must list the location and Google Maps url of each minibus stop.
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
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, minibus, verbose=True, max_execution_time=10,)
    result = agent.run('Please list the location name, coordinates and google map url of 10 minibus stops')
    
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
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, ferry, verbose=True, max_execution_time=10,)
    result = agent.run('Please list the location name, coordinates and google map url of 8 ferry stops')
    
    return result

minibus_agent_data = minibus_agent()
ferry_agent_data = ferry_agent()



def run_and_compare_queries(minibus, ferry, query: str):
    """Compare outputs of Langchain Agents running on real vs. synthetic data"""
    query_template = f"{query} Execute all necessary queries, and always return results to the query, no explanations or apologies please. Word wrap output every 50 characters."
 
 
    result1 = minibus.run(query_template)
    result2 = ferry.run(query_template)
 
    print("=== Comparing Results for Query ===")
    print(f"Query: {query}")
    
    
    prompt = """Please list and describute the location name and google map url of 2 ferry stops and 2 minibus stops."""
    
    run_and_compare_queries(minibus=minibus_agent_data, ferry=ferry_agent_data, query=prompt)
    
