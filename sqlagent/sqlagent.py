from google.cloud import bigquery
from sqlalchemy import *
from sqlalchemy.engine import create_engine
from sqlalchemy.schema import *
import os
from langchain.agents import create_sql_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain.sql_database import SQLDatabase
from langchain.llms import VertexAI
from langchain.agents import AgentExecutor
from flask import Request, json


def query_bigquery(request):
    # Get query from request
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and "query" in request_json:
        query = request_json["query"]
    elif request_args and "query" in request_args:
        query = request_args["query"]
    else:
        return "Please provide a query string."

    # Set up BigQuery
    service_account_file = "keys/fyp-open-data-hackathon-f209cbd41f8d.json"  # This needs to be accessible in the cloud environment
    project = "fyp-open-data-hackathon"
    dataset = "ferry"
    sqlalchemy_url = (
        f"bigquery://{project}/{dataset}?credentials_path={service_account_file}"
    )

    # Set up langchain
    db = SQLDatabase.from_uri(sqlalchemy_url)
    llm = VertexAI(temperature=0, model="text-bison@001")
    toolkit = SQLDatabaseToolkit(db=db, llm=llm)
    agent_executor = create_sql_agent(
        llm=llm,
        toolkit=toolkit,
        verbose=True,
        top_k=1000,
        temperature=0.9,
        max_tokens=200,
    )

    # Execute query
    response = agent_executor.run(query)
    return response


# This is a simple wrapper to simulate a Flask Request for local testing
class SimulatedRequest:
    def __init__(self, json_body):
        self.json_body = json_body

    def get_json(self, silent=False):
        return self.json_body

    @property
    def args(self):
        return self.json_body


# Now use this class to simulate a request
simulated_request = SimulatedRequest(
    {"query": "What is the price of Single Journey - Adult? just check eng table"}
)

# Call your function with the simulated request
result = query_bigquery(simulated_request)

# Print out the response from your function
print(result)
