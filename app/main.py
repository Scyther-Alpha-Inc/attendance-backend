import asyncio
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

from app.pre_populate import pre_populate
from core.exceptions.simple_exception import SimpleException
from .db.database_session import sessionmanager
from .routers import router


@asynccontextmanager
async def lifespan(app: FastAPI):
    await sessionmanager.init_models()
    await pre_populate()
    yield

    if sessionmanager._engine is not None:
        await sessionmanager.close()


app = FastAPI(lifespan=lifespan)
app.include_router(router)


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}


@app.exception_handler(SimpleException)
async def simple_exception_handler(request: Request, exception: SimpleException):
    if isinstance(exception, SimpleException):
        response_dict = {
            "message": exception.message,
            "type": exception.err_type.value,
        }

        return JSONResponse(
            status_code=exception.status_code,
            content=response_dict,
        )
