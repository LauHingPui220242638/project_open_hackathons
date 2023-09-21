import pandas as pd
import os
from langchain.agents import BaseAgent, Agent, agent
from langchain.tools import BaseTool, Tool, tool
from langchain.agents import create_csv_agent



credential = "fyp-open-data-hackathon-7fccdf48c91c.json"

credential_path = os.path.join(os.getcwd(), credential)
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


tools = [
    Tool(
        name="WasteRecycling_Locations",
        func=wasterecycling_location().run,
        description="Find the nearest waste recycling location"
    ),

    Tool( 
        name="Surplus_Food_Recovery_Locations",
        func=surplus_food_recovery().run,
        description="Find the type of surplus food recovery location"
    )
]

class wasterecycling_location(BaseTool):
    name = "WasteRecycling_Locations"
    description = "Find the nearest waste recycling location"
    def _run(self, query: str) -> str:
        raise seach_location(query)
    async def _arun(self, query: str) -> str:
        raise NotImplementedError("No data!")

def seach_location(query):
    read = "https://www.wastereduction.gov.hk/sites/default/files/wasteless07.csv"
    data_file = pd.read_csv(read)
    location = data_file.to_dict('records')
    queries = [q.strip() for q in query.split(", ")]
    matching_location = []

    for query in queries:
        found = False
            for place in location:
                if query.lower() in place["0|&"].lower():
                    matching_location.append(place)
                    found = True
    return matching_location
    
data1 = seach_location("Tai Wong Ha Resite Village")
data1
    

class surplus_food_recovery(BaseTool):
    name = "Surplus_Food_Recovery_Locations"
    description = "Find the type of surplus food recovery location"
    def _run(self, query: str) -> str:
        raise seach_food_recovery_location(query)
    async def _arun(self, query: str) -> str:
        raise NotImplementedError("No data!")

def seach_location(query):
    url = "https://static.csdi.gov.hk/csdi-webpage/download/common/bac8af4a8f6fe42a7e6124fbedcb9d2227b2b1a6f72d78e8903421307aeb58e8"
    agent = create_csv_agent(VertexAI("text-bison@001", temperature=0.2), url, agent_type=AgentType.ZERO_SHOT_REACT_DESCRIPTION)
    result = agent.run(query)
    return result

data = seach_food_recovery_location("North District Food Collection Centre")
data
