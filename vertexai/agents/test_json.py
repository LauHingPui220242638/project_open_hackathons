import vertexai
import geopandas as gpd
import os


from langchain.llms import VertexAI
from langchain.embeddings import VertexAIEmbeddings
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
from langchain.document_loaders import JSONLoader


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
    
loader = JSONLoader(
    file_path = './data/bus.json',
    jq_schema = '.features[]'
    )
data = loader.load()

#file_path = './data/bus.geojson'
#data = gpd.read_file(file_path)

text_splitter = CharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=10
    )
texts = text_splitter.split_documents(data)
embeddings = VertexAIEmbeddings()
llm_chain = LLM_init()
vertex_ai_model = VertexAI(
    model_name='text-bison-32k',
    llm_chain=llm_chain,
    max_output_tokens=1000,
    temperature=0.1,
    top_p=0.3
)
docsearch = Chroma.from_documents(texts, embeddings)
qa = RetrievalQA.from_chain_type(vertex_ai_model=vertex_ai_model, chain_type="stuff", retriever=docsearch.as_retriever())

qa.run("Where are mtr? Give me three option.")