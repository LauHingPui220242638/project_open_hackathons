gcloudfunc="gcloudfunc-chatbot"
gcloudfunc="gcloudfunc-chatbot-map"
gcloudfunc="test-hong"
gcloudfunc="demo"

curl -m 70 -X POST https://asia-east1-fyp-open-data-hackathon.cloudfunctions.net/$gcloudfunc \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
  "user_id": "Leo",
  "data": {
    "chat": "替孩子申請",
    "kind": "text",
    "coordinates": [0.0,0.0,0.0]
  }
}'



