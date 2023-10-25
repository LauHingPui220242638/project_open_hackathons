# api_key="$1"
api_key=AIzaSyCVlOJ5g15PLuYx5ZGng8CVczi4vRXsBvI
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