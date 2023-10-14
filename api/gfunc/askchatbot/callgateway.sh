# api_key="$1"
api_key=AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM
curl https://api-gateway-7923qjyk.ue.gateway.dev/ask?api_key=$api_key \
    --request POST \
    --data '{
        "user_id": "00000000",
        "data": {
            "question": "How are you"
        }
    }'
