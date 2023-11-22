backend=https://cloudrun-backend-qskzidtbhq-de.a.run.app
backend=http://localhost:8080

api_key=AIzaSyDdhMPubp8gw0GIzVnGMzG7bAWAGNuvwlM
curl -X 'POST' \
  "${backend}/ask?api_key=${api_key}" \
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