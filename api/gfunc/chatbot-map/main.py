import json
import functions_framework

import vertexai
import geopandas as gpd

from langchain.llms import VertexAI
from langchain.agents import create_pandas_dataframe_agent
from langchain import PromptTemplate, LLMChain
from langchain.memory import ConversationBufferMemory


def LLM_init():
    template = """
    You have some ferry stop geojson file. 
    You must list the location and Google Maps url of each ferry stop.
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


def mtr_agent():

    path = 'mtr.geojson'
    
    mtr = gpd.read_file(path)
        
    llm_chain = LLM_init()
    vertex_ai_model = VertexAI(
        model_name='text-bison-32k',
        llm_chain=llm_chain,
        max_output_tokens=500,
        temperature=0.3,
        top_p=0.8,
        top_k=40
    )
    
    agent = create_pandas_dataframe_agent(vertex_ai_model, mtr, verbose=True,max_execution_time=20,)

    result = agent.run('Please list the coordinates of 1 mtr station. Return JSON format. You must like this [65.453, 92.344 , 12.2]')

    return result




@functions_framework.http
def ask(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    """
    request_json = request.get_json(silent=True)
    request_args = request.args

    data = mtr_agent()

    dataDict = json.loads(data)


    response_data = {
        "user_id": "AI",
        "data": {
            "chat": "Here is a location for your reference!",
            "kind": "map",
            "coordinates": dataDict
        }
    }

    response_json = json.dumps(response_data)

    return response_json, 200, {'Content-Type': 'application/json'}
