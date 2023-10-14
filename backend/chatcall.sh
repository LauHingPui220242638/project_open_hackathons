# curl https://cloudrun-backend-qskzidtbhq-de.a.run.app/ask \
curl http://localhost:8080/ask \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{
        "api_key": "AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM",
        "data": {
            "question": "How are you"
            }
        }' \
