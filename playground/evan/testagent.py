from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI
from langchain.agents.agent_types import AgentType
import os
import sys



from langchain.agents import create_csv_agent

os.environ['OPENAI_API_KEY'] = "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"

agent = create_csv_agent(
    ChatOpenAI(temperature=0, model="gpt-3.5-turbo-0613"),
    "https://www.immd.gov.hk/opendata/hkt/transport/immigration_clearance/statistics_on_daily_passenger_traffic.csv",
    verbose=True,
    agent_type=AgentType.OPENAI_FUNCTIONS,
)

agent.run("how many rows are there?")