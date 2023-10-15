# api_key="$1"
api_key=AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM
curl -X 'POST' \
  "https://api-gateway-7923qjyk.ue.gateway.dev/ask?api_key=${api_key}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user_id": "00000000",
  "data": {
    "question": "HIHIHI"
  }
}'