step:
gcloud auth login
gcloud config set project fyp-open-data-hackathon

gcloud builds submit --config cloudbuild.yaml .
gcloud builds list

gcloud functions call query_bigquery --data '{"query": "What is the price of Single Journey - Adult? just check eng table"}'
gcloud functions logs read query_bigquery

---
to test:
curl -m 70 -X POST https://asia-east1-fyp-open-data-hackathon.cloudfunctions.net/query_bigquery \
-H "Authorization: bearer $(gcloud auth print-identity-token)" \
-H "Content-Type: application/json" \
-d '{"query": "What is the price of Single Journey - Adult? just check eng table"}'



---
caching:
chat -> memorystore / firestore -> if exist: -> response
		    else: for n agent:(agent -> save response to memorystore / firestore) -> response



{
  question:'abc',
  response:'xyz',
}
