# api_key="$1"
# api_gw=https://api-gateway-7923qjyk.ue.gateway.dev
api_gw=https://api-gw-chatbot-7923qjyk.an.gateway.dev
# api_key=AIzaSyCVlOJ5g15PLuYx5ZGng8CVczi4vRXsBvI
api_key=AIzaSyDdhMPubp8gw0GIzVnGMzG7bAWAGNuvwlM
urlPath=ask-image
curl -X 'POST' \
  "${api_gw}/${urlPath}?api_key=${api_key}" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "user_id": "Leo",
  "data": {
    "chat": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Polynomial_of_degree_three.svg/800px-Polynomial_of_degree_three.svg.png what is this?",
    "kind": "image",
    "coordinates": [0.0,0.0,0.0]
  }
}'