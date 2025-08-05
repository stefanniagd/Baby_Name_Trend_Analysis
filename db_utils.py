
#Import the libraries
from sqlalchemy import create_engine
import pandas as pd
import os
from dotenv import load_dotenv 
from pathlib import Path

# Load environment variables from .env file into os.environ
load_dotenv()

# Get credentials from .env
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_NAME")



# Run SQL query and return the DataFrame
def run_query(query):
    # Create SQL ALchemy engine
    engine = create_engine(f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}")
    df = pd.read_sql(query, engine)
    return df


# File utils
def load_query(filename):
    return Path(f"queries/{filename}").read_text()
