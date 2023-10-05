import os
import geojson
import requests
import json


def jsonDownload(url):
    file_path = "./geojson.json"
    print(file_path)
    response = requests.get(url)
    if response.status_code == 200:
        
        geojson_data = response.content.decode("utf-8-sig")
        # json_data = json.dumps(geojson_data)

    with open(file_path, "w", encoding="utf-8-sig") as json_file:
        json_file.write(geojson_data)
    return file_path
# with open('path_to_file') as f:
#     gj = geojson.load(f)
# features = gj['features'][0]


#print(jsonData)

if __name__ == "__main__":
    jsonData = jsonDownload(url='https://static.data.gov.hk/td/routes-fares-geojson/JSON_GMB.json')