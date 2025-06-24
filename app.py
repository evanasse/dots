from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Define a data model for the request body
class Item(BaseModel):
    name: str
    description: str = None
    price: float
    tax: float = None

# Root endpoint
@app.get("/")
async def root():
    return {"message": "Hello World"}

# Example endpoint with path parameter
@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}

# Example endpoint with query parameter
@app.get("/items/")
async def read_items(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}

# Example endpoint with request body
@app.post("/items/")
async def create_item(item: Item):
    return item
