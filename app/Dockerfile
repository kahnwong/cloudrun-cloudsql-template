FROM python:3.11-slim

# app deps
# hadolint ignore=DL3045
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# app
WORKDIR /opt/app
COPY . .

EXPOSE 8080
CMD uvicorn cloud_run_cloud_sql_template.main:app --port 8080 --host 0.0.0.0
