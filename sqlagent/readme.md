step:
gcloud auth login
gcloud config set project fyp-open-data-hackathon

gcloud builds submit --config cloudbuild.yaml .
gcloud builds list

gcloud functions call query_bigquery --data '{"query": "What is the price of Single Journey - Adult? just check eng table"}'
gcloud functions logs read query_bigquery

---
docker build -t query_bigquery .
docker run -p 8080:8080 query_bigquery

