from os import environ as env
from typing import Union

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": env.get("MESSAGE", "Default")}
