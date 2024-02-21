import json
import functions_framework
import vertexai

from vertexai.preview.generative_models import GenerativeModel, Part
import vertexai.preview.generative_models as generative_models


def generate(question:str):
  model = GenerativeModel("gemini-pro-vision")
  responses = model.generate_content(
    question,
    generation_config={
        "max_output_tokens": 2048,
        "temperature": 0.4,
        "top_p": 1,
        "top_k": 32
    },
    safety_settings={
          generative_models.HarmCategory.HARM_CATEGORY_HATE_SPEECH: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
          generative_models.HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
          generative_models.HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
          generative_models.HarmCategory.HARM_CATEGORY_HARASSMENT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
    },
    stream=True,
  )

  result = []
  for response in responses:
    result.append(response.text)
    print(response.text, end="")

  chat = "\n".join(result)
  print(chat)

  return chat

@functions_framework.http
def ask(request):

  request_json = request.get_json(silent=True)
  request_args = request.args

  #user_id = request_json.get('user_id')
  data = request_json.get('data')
  question = data.get('chat')
  answer = generate(question=question)

  response_data = {
    "user_id": "AI",
    "data": {
      "chat": answer,
      "kind": "text",
      "coordinates":  [123.21, 13.2323, 12.2]
    }
  }

  response_json = json.dumps(response_data)

  return response_json, 200, {'Content-Type': 'application/json'}
