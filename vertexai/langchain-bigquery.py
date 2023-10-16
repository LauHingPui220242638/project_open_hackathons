from langchain.document_loaders import BigQueryLoader


def bigquery(query):
    loader = BigQueryLoader(query)
    data = loader.load()
    return data

BASE_QUERY = """
SELECT * FROM `fyp-open-data-hackathon.test.test` LIMIT 10;"""


result = bigquery(BASE_QUERY)
print(result)
