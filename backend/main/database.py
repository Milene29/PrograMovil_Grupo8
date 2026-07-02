import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

class ToString:
  def to_dict(self):
    return {
      key: value
      for key, value in self.__dict__.items()
      if not key.startswith('_')
    }
  
  def __repr__(self):
    return f"<{self.__class__.__name__}({', '.join(f'{key}={value}' for key, value in self.__dict__.items() if not key.startswith('_'))})>"

db_url = os.environ.get('DATABASE_URL', "postgresql://postgres.ozteytmdkbdnpfffgudb:Salvador70258802.@aws-1-ca-central-1.pooler.supabase.com:5432/postgres")
engine = create_engine(db_url, echo=True)
Session = sessionmaker(bind=engine)
