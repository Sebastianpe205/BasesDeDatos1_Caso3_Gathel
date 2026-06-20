FROM python:3.12-slim

# TODO: instalar dependencias del sistema necesarias para el driver ODBC
#       de SQL Server (unixodbc, msodbcsql18, etc.)

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# TODO: definir variables de entorno por defecto si aplica

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
