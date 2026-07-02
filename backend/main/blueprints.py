from main.apis import api as main_apis
from cafe.cafe_blueprints import blueprints as cafe_blueprints

def register(app):
  modules_blueprints = [
    cafe_blueprints,
  ]
  app.register_blueprint(main_apis)
  for blueprints in modules_blueprints:
    for blueprint in blueprints:
      app.register_blueprint(blueprint)