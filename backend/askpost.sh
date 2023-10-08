# curl http://localhost:8080/ask \
curl https://cloudrun-backend-qskzidtbhq-de.a.run.app/ask \
    --header "Content-Type: application/json" \
    --request POST \
    --data '{"question": "How are you"}' \
