from flask import Flask, jsonify
from flask_cors import CORS


# configuration
DEBUG = False
__name__ = '__main__'
# instantiate the app

app = Flask(__name__)
app.config.from_object(__name__)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})


@app.route('/')
def index():
  return "Hello world!"

# sanity check route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')