FROM python:3.11-slim as base

# Create non-root user with UID 1001
RUN addgroup --system --gid 1001 appgroup && adduser --system --uid 1001 --ingroup appgroup appuser

WORKDIR /app

COPY ../app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ../app .

USER appuser

EXPOSE 8080

CMD ["python", "src/app.py"]
