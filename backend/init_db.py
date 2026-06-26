"""
Ejecutar una sola vez para crear las tablas e insertar datos de ejemplo.
  python init_db.py
"""
from biblio.models import Base, Category, Product, User
from main.database import engine, Session

# Crear todas las tablas
Base.metadata.drop_all(engine)
Base.metadata.create_all(engine)

session = Session()

# ── Categorías (mismo orden que el mock) ────────
cat_calientes = Category(name="Bebidas Calientes")
cat_frias = Category(name="Bebidas Frías")
cat_snacks = Category(name="Snacks & Postres")

session.add_all([cat_calientes, cat_frias, cat_snacks])
session.flush()

# ── Productos ───────────────────────────────────
products = [
  Product(
    name="Café Americano",
    description="Café negro de filtro preparado con granos selectos de altura.",
    price=5.50,
    image="https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500&auto=format&fit=crop",
    prep_time="3 min",
    is_recommended=False,
    category_id=cat_calientes.id
  ),
  Product(
    name="Cappuccino",
    description="Espresso con espuma de leche perfecta y toque de canela.",
    price=7.00,
    image="https://images.unsplash.com/photo-1534778101976-62847782c213?w=500&auto=format&fit=crop",
    prep_time="3 min",
    is_recommended=True,
    category_id=cat_calientes.id
  ),
  Product(
    name="Latte",
    description="Espresso suave con leche vaporizada.",
    price=7.50,
    image="https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500&auto=format&fit=crop",
    prep_time="3 min",
    is_recommended=True,
    category_id=cat_calientes.id
  ),
  Product(
    name="Croissant",
    description="Clásico pan francés crujiente y hojaldrado, horneado diariamente.",
    price=6.00,
    image="https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=500&auto=format&fit=crop",
    prep_time="2 min",
    is_recommended=True,
    category_id=cat_snacks.id
  ),
  Product(
    name="Mocaccino",
    description="Café con leche y caramelo dulce, coronado con crema batida.",
    price=7.50,
    image="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYVmS6txB28CIcIYcNVKvaoQXIoqa_s8g-QNguvg4ImttEmxWnX2WEA6ckFmRWMLFzuoNI9TYVaKB8r7r32TIt5YLNE7omq9EBqIdrNM8&s=10",
    prep_time="4 min",
    is_recommended=False,
    category_id=cat_calientes.id
  ),
  Product(
    name="Iced Latte",
    description="Espresso frío con leche vaporizada fresca y cubos de hielo.",
    price=8.50,
    image="https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500&auto=format&fit=crop",
    prep_time="4 min",
    is_recommended=False,
    category_id=cat_frias.id
  ),
  Product(
    name="Frappuccino",
    description="Café licuado con hielo, leche y decorado con crema batida.",
    price=9.50,
    image="https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500&auto=format&fit=crop",
    prep_time="5 min",
    is_recommended=True,
    category_id=cat_frias.id
  ),
  Product(
    name="Muffin de Chocolate",
    description="Muffin suave relleno de chispas de chocolate belga.",
    price=6.50,
    image="https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=500&auto=format&fit=crop",
    prep_time="1 min",
    is_recommended=False,
    category_id=cat_snacks.id
  ),
]

session.add_all(products)

# ── Usuarios de prueba ──────────────────────────
users = [
    User(
        username="20203263",
        password="123456",
        first_name="Pedro",
        last_name="Morales",
        email="20203263@aloe.ulima.edu.pe",
        status=True
    ),
    User(
        username="20211111",
        password="123456",
        first_name="Milene",
        last_name="Garrido",
        email="20211111@aloe.ulima.edu.pe",
        status=True
    ),
    User(
        username="20194536",
        password="123456",
        first_name="Salvador",
        last_name="Rodriguez",
        email="20194536@aloe.ulima.edu.pe",
        status=True
    ),
    User(
        username="20230286",
        password="123456",
        first_name="Sebastian",
        last_name="Balbuena",
        email="20230286@aloe.ulima.edu.pe",
        status=True
    ),
    User(
        username="20221190",
        password="123456",
        first_name="Jairo",
        last_name="Gutierrez",
        email="20221190@aloe.ulima.edu.pe",
        status=True
    ),
]

session.add_all(users)
session.commit()
session.close()

print("Base de datos creada con éxito.")
print(f"  - 3 categorías")
print(f"  - {len(products)} productos")
print(f"  - {len(users)} usuarios")