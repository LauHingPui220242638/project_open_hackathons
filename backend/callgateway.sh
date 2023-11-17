# api_key="$1"
# api_gw=https://api-gateway-7923qjyk.ue.gateway.dev
api_gw=https://api-gw-chatbot-7923qjyk.an.gateway.dev
# api_key=AIzaSyCVlOJ5g15PLuYx5ZGng8CVczi4vRXsBvI
api_key=AIzaSyDdhMPubp8gw0GIzVnGMzG7bAWAGNuvwlM
curl -X 'POST' \
  "${api_gw}/ask?api_key=${api_key}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user_id": "Leo",
  "data": {
    "chat": "HIHIHI",
    "kind": "text",
    "coordinates": [0.0,0.0,0.0]
  }
}'