from flask import Flask, jsonify
from flask_cors import CORS

# configuration
DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)


# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})


@app.route('/')
def hello_world():  # put application's code here
    return 'DONT GO TO BED!'


# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong from App.py!')


if __name__ == '__main__':
    app.run()
