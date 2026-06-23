from .apis.category import api as api_categories
from .apis.product import api as api_products
from .apis.order import api as api_orders
from .apis.user import api as api_users

blueprints = [
  api_categories,
  api_products,
  api_orders,
  api_users,
]