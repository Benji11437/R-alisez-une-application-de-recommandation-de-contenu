# Image de base
FROM python:3.10-slim

# éviter les .pyc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# dossier de travail
WORKDIR /app

# dépendances système (utile pour surprise)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# copier requirements
COPY requirements.txt .

# installer dépendances
RUN pip install --no-cache-dir -r requirements.txt

# copier le code
COPY . .

# port utilisé par FastAPI
EXPOSE 8080

# lancer l'app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]