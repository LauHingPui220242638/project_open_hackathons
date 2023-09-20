import vertexai
from vertexai.language_models import TextGenerationModel

vertexai.init(project="fyp-open-data-hackathon", location="us-central1")
parameters = {
    "candidate_count": 1,
    "max_output_tokens": 256,
    "temperature": 0.2,
    "top_p": 0.8,
    "top_k": 40
}
model = TextGenerationModel.from_pretrained("text-bison@001")
response = model.predict(
    """HELLO""",
    **parameters
)
print(f"Response from Model: {response.text}")