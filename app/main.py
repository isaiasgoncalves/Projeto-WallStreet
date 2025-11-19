import streamlit as st
import sqlalchemy
import pandas as pd

st.set_page_config(layout="wide", page_title="Projeto Wall Street")

st.title("Teste de configuração de ambiente")

st.write("Se você está vendo isso, o Streamlit está rodando via Docker")

# Teste de conexão
st.info(f"Versão do SQLAlchemy: {sqlalchemy.__version__}")
st.info{f"Versão do Pandas instalada: {pd.__version__}"}
