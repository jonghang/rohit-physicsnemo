from fastapi import FastAPI

app = FastAPI(title="rohit-physicsnemo-api", version="0.1.0")


@app.get("/")
def root():
    return {"message": "Hello from rohit-physicsnemo-api!"}


@app.get("/health")
def health():
    return {"status": "ok"}
