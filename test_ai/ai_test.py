from langchain import SerpAPIWrapper
from langchain.agents import initialize_agent, Tool
from langchain.agents import AgentType
from langchain.chat_models import ChatOpenAI
import getpass
import os

os.environ["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"] = getpass.getpass()

# Initialize the OpenAI language model
# Replace <your_api_key> in openai_api_key="<your_api_key>" with your actual OpenAI key.
llm = ChatOpenAI(temperature=0, model="gpt-3.5-turbo-0613") 

# Initialize the SerpAPIWrapper for search functionality
# Replace <your_api_key> in serpapi_api_key="<your_api_key>" with your actual SerpAPI key.
search = SerpAPIWrapper()

# Define a list of tools offered by the agent
tools = [
    Tool(
        name="Search",
        func=search.run,
        description="Useful when you need to answer questions about current events. You should ask targeted questions.",
    ),
]

mrkl = initialize_agent(
    tools, llm, agent=AgentType.OPENAI_MULTI_FUNCTIONS, verbose=True
)

# Do this so we can see exactly what's going on under the hood
import langchain

langchain.debug = True

mrkl.run("What is the weather in LA and SF?")
