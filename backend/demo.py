from sqlalchemy import select, func, text
from main.database import Session
from main.models import BodyPart, Exercise

def listar_bodyparts():
  session = Session()
  body_parts = session.query(BodyPart).all() # SELECT * FROM body_parts;
  for body_part in body_parts:
    print(body_part)

def listar_bodyparts_filtro(num):
  # SELECT name FROM body_parts WHERE id > 4
  session = Session()
  resultados = session.query(BodyPart.name).filter(BodyPart.id > num).all()
  # Mostrar los resultados
  for nombre in resultados:
    print(nombre[0])  # Accede al valor del nombre

def editar_bodypart(body_part_id, name):
  session = Session()
  # SELECT * FROM body_parts WHERE id = :body_part_id LIMIT 1
  body_part = session.query(BodyPart).filter_by(id=body_part_id).first()
  if body_part:
    body_part.name = name
    session.commit()
    print(f"Body Part actualizado: {body_part}")
  else:
    print(f"No se encontró ningún body_part con ID {body_part_id}")

def crear_body_part(name):
  body_part = BodyPart(name=name)
  session = Session()
  session.add(body_part)
  session.commit()
  print(body_part.id)

def borrar_body_part(body_part_id):
  session = Session()
  # SELECT * FROM body_parts WHERE id = :body_part_id LIMIT 1
  body_part = session.query(BodyPart).filter_by(id=body_part_id).first()
  if body_part:
    session.delete(body_part)
    session.commit()
    print(f"Body Part actualizado: {body_part}")
  else:
    print(f"No se encontró ningún body_part con ID {body_part_id}")

def query3():
  session = Session()
  resultados = session.query(Exercise, BodyPart).join(BodyPart).all()

  # Mostrar los resultados
  for ejercicio, parte_cuerpo in resultados:
      print(f"Ejercicio: {ejercicio.name}, Parte del Cuerpo: {parte_cuerpo.name}")

def query4():
  session = Session()
  sql = text("SELECT exercises.name, body_parts.name AS body_part FROM exercises JOIN body_parts ON exercises.body_part_id = body_parts.id")
  # Ejecutar la consulta
  result = session.execute(sql)
  # Mostrar los resultados
  for row in result:
    print(f"Ejercicio: {row[0]},,,,,,,,,, Parte del Cuerpo: {row[1]}")



#listar_bodyparts_filtro(4)
#editar_bodypart(100, 'PECHO')
#@crear_body_part('orejas')
#borrar_body_part(7)
#borrar_body_part(8)
#borrar_body_part(9)
query4()