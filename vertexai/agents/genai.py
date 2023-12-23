import json
import vertexai
import os
from vertexai.preview.language_models import TextGenerationModel

credential = "/workspaces/project_open_hackathons/secretes/shaped-storm-401909-adaff701b395.json"
credential_subpath = os.path.join("secretes", credential)
credential_path = os.path.join(os.path.dirname(os.getcwd()) ,credential_subpath  )
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path


def generationai_function():
    prompt = """Summarize the following conversation between a service rep and a customer in a few sentences. 
    Use only the information from the conversation.
    """
    
    generation_model = TextGenerationModel.from_pretrained("text-bison-32k")

    generation = generation_model.predict(
        prompt=prompt,
        max_output_tokens=256,
        temperature=0.2,
        top_p=0.3
    ).text
        
    response = generation_model.predict('What is food?')
    return response.text

result = generationai_function()
print(result)