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

    query = request_json["data"]["chat"]
    if '覆診' in query :
      response_data = {
        "user_id": "AI",
        "data": {
          "chat": "冇錯。你喺今日11點喺廣華醫院眼科門診有預約。由於現時交通擠塞，建議您乘坐地鐵到目的地。",
          "kind": "map",
          "coordinates": [22.3148608, 114.1707598, 17.75]
          }
        }
    elif '替孩子申請' in query :
      response_data = {
        "user_id": "AI",
        "data": {
          "chat": "冇錯。你喺今日11點喺廣華醫院眼科門診有預約。由於現時交通擠塞，建議您乘坐地鐵到目的地。",
          "kind": "map",
          "coordinates": [22.3152394, 114.2252462, 19]
          }
        }
    elif '有啲唔舒服' in query :
      response_data = {
        "user_id": "AI",
        "data": {
          "chat": "你可以到最近的民政事務處索取小一入學申請表，填妥後交到觀塘偉業街223號宏利金融中心2樓2室教育局學位分配組。以下是最近的民政事務處位置",
          "kind": "map",
          "coordinates": [22.3132469, 114.2212449, 18]
          }
        }
    elif '廁所' in query :
      response_data = {
        "user_id": "AI",
        "data": {
          "chat": "圖片顯示左面是男廁，右面是女廁。",
          "kind": "text",
          "coordinates": [0, 0, 0]
          }
        }
    return response_data