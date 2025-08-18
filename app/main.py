from contextlib import asynccontextmanager
from fastapi import FastAPI
from .db.database_session import sessionmanager
from .routers import router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await sessionmanager.init_models()
    yield

    if sessionmanager._engine is not None:
        await sessionmanager.close()


app = FastAPI(lifespan=lifespan)
app.include_router(router)


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}
