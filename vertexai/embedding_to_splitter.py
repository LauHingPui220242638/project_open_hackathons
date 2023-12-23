import vertexai
import os
import geopandas as gpd

from langchain.embeddings import VertexAIEmbeddings
from langchain.vectorstores import Chroma
from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain.tools import GooglePlacesTool, Tool
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.schema import Document



credential = "/workspaces/project_open_hackathons/secretes/shaped-storm-401909-adaff701b395.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path
os.environ["GPLACES_API_KEY"] = './secretes/map_api_key.txt'

PROJECT_ID = 'shaped-storm-401909'
LOCATION = 'us-central1'
vertexai.init(project=PROJECT_ID, location=LOCATION)


def LLM_init():
    template = """
    You have some ferry stop geojson file. 
    You must list the location and Google Maps url of each ferry stop.
    {chat_history}
        Human: {human_input}
        Chatbot:"""

    prompt_for_llm = PromptTemplate(
        template=template,
        input_variables=["chat_history","human_input"]
    )
    
    memory = ConversationBufferMemory(
        memory_key="chat_history",
        return_messages=True
    )
    
    vertex_ai_model = VertexAI()

    llm_chain = LLMChain(
        prompt=prompt_for_llm,
        llm=vertex_ai_model,
        memory=memory
    )
    
    return llm_chain

def ferry_agent():
    ferry = gpd.read_file(
        'https://static.data.gov.hk/td/routes-fares-geojson/JSON_FERRY.json',
        rows=20
    )
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name="text-bison-32k",
        llm_chain=llm_chain,
        max_output_tokens=2000,
        temperature=0,
        top_p=0.1
    )
    
    agent = create_pandas_dataframe_agent(
        vertex_ai_model,
        ferry,
        max_execution_time=60,
        verbose=True
    )
    
    result = agent.run(human_input = 'Please use english complete sentences to describe 20 ferry StartNameE to EndNameE, coordinates and google_map_url.')
    return result


data = ferry_agent()

embeddings = VertexAIEmbeddings(model="models/embedding-001")

#doc_result = embeddings.embed_documents([data])
docs = [
    Document(
        page_content = data
    )
]

db = Chroma.from_documents(docs, embeddings)

query = "How to go to Central from Cheung Chau? Give me a suggestion."
docs = db.similarity_search(query)

print(docs[0].page_content)
#print(doc_result)