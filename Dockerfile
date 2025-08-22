FROM ghcr.io/astral-sh/uv:python3.12-bookworm


RUN mkdir /app

WORKDIR /app

COPY . .

# RUN mkdir /app    

# WORKDIR /app

RUN uv sync
# RUN uv run pre_populate
# CMD ["fastapi", "run", "app/main.py", "--host", "0.0.0.0", "--port", "8083", "--reload", "--proxy-headers"]


