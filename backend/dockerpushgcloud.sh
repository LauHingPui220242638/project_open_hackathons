gcloud auth configure-docker asia-east1-docker.pkg.dev
docker tag backend:latest asia-east1-docker.pkg.dev/fyp-open-data-hackathon/backend/backend:latest
gcloud docker -- push asia-east1-docker.pkg.dev/fyp-open-data-hackathon/backend/backend:latest