# curl https://cloudrun-backend-qskzidtbhq-de.a.run.app/ask \
curl http://localhost:8080/ask?api_key=AIzaSyA5jhZl3dPpOsr5DX4_pCgA4ibI7sDfNOM \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{
        "user_id": "00000000",
        "data": {
            "question": "How are you"
            }
        }'

