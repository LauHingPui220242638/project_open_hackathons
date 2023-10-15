import os

credential = "fyp-open-data-hackathon-7fccdf48c91c.json"
credential_path = os.getcwd() + "/secretes/" + credential
os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_path

print(credential_path)

print(os.getcwd())