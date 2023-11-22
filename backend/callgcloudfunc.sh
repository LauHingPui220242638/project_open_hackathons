gcloudfunc="gcloudfunc-chatbot-map"
gcloudfunc="gcloudfunc-chatbot"

curl -m 70 -X POST https://asia-east1-fyp-open-data-hackathon.cloudfunctions.net/$gcloudfunc \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
  "user_id": "Leo",
  "data": {
    "chat": "Where is hospital?",
    "kind": "text",
    "coordinates": [0.0,0.0,0.0]
  }
}'



