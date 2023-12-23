import vertexai
import os

from langchain.llms import VertexAI
from langchain.memory import ConversationBufferMemory
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate


credential = "/workspaces/project_open_hackathons/secretes/shaped-storm-401909-adaff701b395.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


template = """You are a chatbot having a conversation with a human.
{chat_history}
Human: {human_input}
Chatbot:"""

prompt = PromptTemplate(
    input_variables=["chat_history", "human_input"], template=template
)
memory = ConversationBufferMemory(memory_key="chat_history")

llm = VertexAI(model_name="text-bison-32k")
llm_chain = LLMChain(
    llm=llm,
    prompt=prompt,
    verbose=True,
    memory=memory,
)

llm_chain.predict(human_input="Hi my name is John")
llm_chain.predict(human_input="What is my name?")
output = llm_chain.predict(human_input="What is food?")
print(output)