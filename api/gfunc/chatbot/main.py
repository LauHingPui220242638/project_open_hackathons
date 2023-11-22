import json
import functions_framework
import vertexai

from vertexai.preview.language_models import TextGenerationModel

def generationai_function(chat: str):
    prompt = """Summarize the following conversation between a service rep and a customer in a few sentences. Use only the information from the conversation.
    Response shloud only string, integer or float. For exmaple: 'Hello! Nice too meet you!'
    """
    
    generation_model = TextGenerationModel.from_pretrained("text-bison-32k")

    generation = generation_model.predict(
            prompt=prompt,
            max_output_tokens=256,
            temperature=0.2,
            top_p=0.8,
            top_k=40
        ).text
        
    response = generation_model.predict(chat)
    return response.text


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

    user_id = request_json.get('user_id')
    data = request_json.get('data')
    chat = data.get('chat')
    kind = data.get('kind')
    coordinates = data.get('coordinates')

    result = generationai_function(chat)
    
    response_data = {
        "user_id": "AI",
        "data": {
            "chat": result,
            "kind": "text",
            "coordinates":  [123.21, 13.2323, 12.2]
        }
    }

    response_json = json.dumps(response_data)

    return response_json, 200, {'Content-Type': 'application/json'}
