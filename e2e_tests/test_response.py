from os import environ as env
import requests


HOST_URI = env['HOST_URI']

def test_home():

    print(HOST_URI)
    response = requests.get(HOST_URI)
    print(response.text)
    assert response.json()["message"] == "Default"
