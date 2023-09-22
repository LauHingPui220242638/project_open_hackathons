curl -L -X 'POST' \
  'http://127.0.0.1:8000/uploadfile' \
  -H 'accept: application/json' \
  -H 'Content-Type: multipart/form-data' \
  -F 'file=@bottle.jpg;type=image/jpeg' \
