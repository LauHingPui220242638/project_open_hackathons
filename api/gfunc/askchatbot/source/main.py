import json
import functions_framework


@functions_framework.http
def hello_http(request):
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
    question = data.get('question')
    answer = "I am Fine from Cloud Function"
    response_data = {
        "user_id": user_id,
        "data": {
            "response": "Hello {}! you asked {}, I anwser {}".format(user_id, question, answer)
        }
    }

    response_json = json.dumps(response_data)

    return response_json, 200, {'Content-Type': 'application/json'}
