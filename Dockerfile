FROM python:3.10

ARG IS_PROD=false

ENV IS_PROD=${IS_PROD} \
  PYTHONFAULTHANDLER=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONHASHSEED=random \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100

RUN pip install poetry

WORKDIR /code
COPY poetry.lock pyproject.toml /code/
RUN poetry config virtualenvs.create false && \
  poetry install $($IS_PROD && echo "--no-dev") --no-interaction --no-ansi

COPY . /code

CMD ["uvicorn", "fast_flux.main:app", "--host", "0.0.0.0", "--port", "8080"]
