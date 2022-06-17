from os import environ as env
from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": env.get("MESSAGE", "Default")}
