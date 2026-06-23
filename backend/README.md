DB="sqlite3:db/app.db"

Linux

    $ python3 -m venv ./env
    $ source env/bin/activate

Windows

    > python -m venv venv
    > .\venv\Scripts\activate.bat
    > pip install -r requirements.txt

Crear migración:

  > npm run db:new <nombre-migración>

Ejecutar

  > npm run db:up

Deshacer

  > npm run db:rollback

Prompts

Para models.py

crea a las clases en python para acceder a estas tablas, usando sqalchemy. agrega el to_dict a todos