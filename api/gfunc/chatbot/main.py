import json
import functions_framework


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
    answer = "I am Fine from Cloud Function"
    response_data = {
        "user_id": user_id,
        "data": {
            "chat": "Hello {}! you asked {} with kind {} and coordinates {}, I anwser {}".format(user_id, chat, kind, coordinates, answer),
            "kind": "text",
            "coordinates":  [123.21, 13.2323, 12.2]
        }
    }

    response_json = json.dumps(response_data)

    return response_json, 200, {'Content-Type': 'application/json'}
