gcloud auth configure-docker asia-east1-docker.pkg.dev
docker tag frontend:latest asia-east1-docker.pkg.dev/fyp-open-data-hackathon/frontend/frontend:latest
gcloud docker -- push asia-east1-docker.pkg.dev/fyp-open-data-hackathon/frontend/frontend:latest