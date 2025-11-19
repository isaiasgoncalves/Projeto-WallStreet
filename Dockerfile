FROM python:3.11-slim

# Evita que o Python gere arquivos .pyc e garante logs em tempo real
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Instala dependências do sistema necessárias para o psycopg2
RUN apt-get update && apt-get install -y \ libpq-dev \ gcc \ && rm -rf /var/lib/apt/lists/*

# Instala o Poetry
RUN pip install poetry

# Define o diretório de trabaho
WORKDIR /app

# Copia os arquivos de configurações de dependências
COPY pyproject.toml poetry.lock* /app/

# Instala as dependências
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copia o código da aplicação para dentro do container
COPY app /app/app

# Expõe a porta padrão do Streamlit
EXPOSE 8501

# Comando para rodar a aplicação e verificar saúde
HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Executa o Streamlit apontando para o arquivo main.py dentro de app/
ENTRYPOINT ["streamlit", "run", "app/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
