import os

import psycopg2  # type: ignore
from cloud_run_cloud_sql_template.model.response import ResponseItem
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()

app = FastAPI(title="cloud_run_cloud_sql_template")

POSTGRES_HOSTNAME = os.getenv("POSTGRES_HOSTNAME")
POSTGRES_USERNAME = os.getenv("POSTGRES_USERNAME")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_DBNAME = os.getenv("POSTGRES_DBNAME")
POSTGRES_PORT = os.getenv("POSTGRES_PORT")

pg_conn = psycopg2.connect(
    host=POSTGRES_HOSTNAME,
    user=POSTGRES_USERNAME,
    password=POSTGRES_PASSWORD,
    dbname=POSTGRES_DBNAME,
    port=POSTGRES_PORT,
)


#######################
# routes
#######################
@app.get("/version")
async def root():
    return {"version": "0.1.0"}


@app.get("/debug", response_model=ResponseItem)
async def main() -> ResponseItem:
    cursor = pg_conn.cursor()

    query = """
            SELECT current_database();
        """

    cursor.execute(query)

    r = cursor.fetchone()[0]

    payload = str({"current_database": r})
    return ResponseItem(payload=payload)
