from flask import Flask, Blueprint, render_template, jsonify, current_app
from flask_socketio import SocketIO
from flask_restful import Api, Resource
from os import sched_getaffinity
import psutil
import subprocess
from .config import ProductionConfig
from .util import utc_now

##############################################

index_bp = Blueprint(name='index', import_name=__name__, url_prefix='/')

status_bp = Blueprint(name='status', import_name=__name__,)

status_api = Api(status_bp)

##############################################
    
@index_bp.route('/', methods=['GET'])
def index():
    return render_template('index.html')

##############################################

app = Flask(__name__)
    
app.config.from_object(ProductionConfig)

socketio = SocketIO(app)

app.register_blueprint(status_bp)
app.register_blueprint(index_bp)

if __name__ == '__main__':
    socketio.run(app)

##############################################    

active_connections_counter = 0

@socketio.on('connect', namespace='/')
def connect():
    global active_connections_counter
    active_connections_counter += 1
    print("A new client connected")

@socketio.on('disconnect', namespace='/')
def disconnect():
    global active_connections_counter
    active_connections_counter -= 1
    print("One of clients diconnected")

##############################################

class StatusResource(Resource):
    def get(self):
        test = current_app.test_client()
        response = test.get('/')
        return jsonify(
            {
                'status': 'up' if response.status_code == 200 else 'down',
                'active_connections': active_connections_counter,
                'ip_address': subprocess.check_output(['hostname', '-I']).decode('utf-8')[:-1].split()[0],
                'memory_total': round(psutil.virtual_memory().total / 1024**2), 
                'cpu_total': len(sched_getaffinity(0)),
                'current_datetime': utc_now(),
            }
        )


status_api.add_resource(StatusResource, '/status', methods=['GET'], endpoint='status')

##############################################
