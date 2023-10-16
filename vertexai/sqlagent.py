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

service_account_file = "keys/fyp-open-data-hackathon-f209cbd41f8d.json" # Change to where your service account key file is located

project = "fyp-open-data-hackathon"

dataset = "liquor"

table = "edatabase_liquor"

sqlalchemy_url = f'bigquery://{project}/{dataset}?credentials_path={service_account_file}'


# Set up langchain

db = SQLDatabase.from_uri(sqlalchemy_url)

llm = VertexAI(temperature=0, model="text-bison@001")

toolkit = SQLDatabaseToolkit(db=db, llm=llm)

agent_executor = create_sql_agent(

llm=llm,

toolkit=toolkit,

verbose=True,

top_k=1000,

)

# First query

agent_executor.run("How many male users churned? ")

