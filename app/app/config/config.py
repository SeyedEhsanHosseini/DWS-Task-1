from os import environ, urandom

class Config:

    ENV = environ.get("APP_ENV", "production")
	
    SECRET_KEY = environ.get("APP_SECRET_KEY", default=urandom(16))	
	
    DEBUG = bool(int(environ.get("APP_DEBUG", "0")))

    TESTING = DEBUG
    
    JSONIFY_PRETTYPRINT_REGULAR = True
    
    RESTFUL_JSON = { "indent": 2 }
    
    JSON_SORT_KEYS = False
    
class DevelopmentConfig(Config):
   DEBUG = True
   SECRET_KEY = 'INSECURE_FOR_LOCAL_DEVELOPMENT'


class ProductionConfig(Config):
   DEBUG = False
   TESTING = False
