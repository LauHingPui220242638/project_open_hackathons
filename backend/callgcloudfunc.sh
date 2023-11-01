curl -m 70 -X POST https://asia-east1-fyp-open-data-hackathon.cloudfunctions.net/gcloudfunc-chatbot \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{
  "user_id": "Leo",
  "data": {
    "chat": "HIHIHI",
    "kind": "text",
    "coordinates": [0.0,0.0,0.0]
  }
}'