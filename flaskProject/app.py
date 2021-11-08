import mysql.connector
from flask import Flask, jsonify, request, make_response
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
from mysql import connector


# configuration
from mysql.connector import Error

DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)
api = Api(app)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})




def create_server_connection(host_name, user_name, user_password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection

def create_database(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        print("Database created successfully")
    except Error as err:
        print(f"Error: '{err}'")

def create_db_connection(host_name, user_name, user_password, port_number, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            password=user_password,
            port=port_number,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection

def db_connect():
    return create_db_connection('localhost', 'admin', 'einherjar', 3306, 'gamedata')

def execute_query(connection, query):
    print("Trying Query:"+query)
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        connection.commit()
        print("Query successful")
    except Error as err:
        print(f"Error: '{err}'")

def read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        print(f"Error: '{err}'")



class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}

api.add_resource(HelloWorld, '/api')

class PingAPI(Resource):
    def get(self):
        print("Returning Ping Get")
        return "PING API!"

api.add_resource(PingAPI, '/ping')

class SessionAPI(Resource):
    def get(self):
        req = request.get_json()
        key = -1
        try:
            key = req.get("key")
        except Exception:
            print(Exception)

        connection = db_connect()
        if key == -1:
            sessions = read_query(connection,'SELECT * FROM sessions')
        else:
            sessions = read_query(connection,f'SELECT * FROM sessions WHERE sessionID={key}')
        print("Returning Sessions GET")
        return jsonify(sessions)

    def post(self):
        req = request.get_json()
        time = req.get("time")
        brain = req.get("brain")
        startingFitness = req.get("startingFitness")
        endingFitness = req.get("endingFitness")
        response_body = {
            "message": "JSON received!",
            "time": req.get("time"),
            "brain": req.get("brain"),
            "startingFitness": req.get("startingFitness"),
            "endingFitness": req.get("endingFitness"),
        }
        res = make_response(jsonify(response_body),200)
        connection = db_connect()
        execute_query(connection,f'INSERT INTO sessions (brain,time,startingFitness,endingFitness) VALUES ({brain}, {time}, {startingFitness}, {endingFitness})')

        return res

    def delete(self):
        #TODO:  Consider deleting this one, should be using Params really
        print("DELETE REQUEST")
        req = request.get_json()
        #request.args seems to be the query string
        sessionID = req.get("sessionID")
        print("SESSION ID:")
        connection = db_connect()
        execute_query(connection,f'DELETE FROM sessions WHERE sessionID={sessionID}')
        return f"performed DELETE on {sessionID}"

class SessionAPIParams(Resource):

    def delete(self, sessionID):
        print("DELETE REQUEST")
        print("SESSION ID:")
        connection = db_connect()
        execute_query(connection,f'DELETE FROM sessions WHERE sessionID={sessionID}')
        return f"performed DELETE on {sessionID}"

    def put(self, sessionID):
        print("PUT/UPDATE REQUEST")
        req = request.get_json()
        time = req.get("time")
        brain = req.get("brain")
        startingFitness = req.get("startingFitness")
        endingFitness = req.get("endingFitness")
        connection = db_connect()
        execute_query(connection,f'UPDATE sessions SET brain = {brain},time = {time},startingFitness = {startingFitness},endingFitness = {endingFitness} WHERE sessionID={sessionID}')
        return f"performed Update on {sessionID}"

api.add_resource(SessionAPI, '/sessions')
api.add_resource(SessionAPIParams, '/sessions/<sessionID>')

class BrainAPI(Resource):
    def get(self):
        print("Received Brain GET")
        req = request.get_json()
        key = -1
        try:
            key = req.get("key")
        except Exception:
            print(Exception)
        if key == -1:
            sessions = read_query(db_connect(),'SELECT * FROM brains')
        else:
            sessions = read_query(db_connect(),f'SELECT * FROM brains WHERE brain={key}')
        print("Returning Brain GET")
        return jsonify(sessions)

    def post(self):
        req = request.get_json()
        brain = req.get("brain")
        fitness = req.get("fitness")
        response_body = {
            "message": "Create received!",
            "brain": req.get("brain"),
            "fitness": req.get("fitness"),
        }
        res = make_response(jsonify(response_body),200)
        execute_query(db_connect(), f'INSERT INTO brains (brain,fitness) VALUES ("{brain}", {fitness})')
        print(res)
        return res

    def delete(self):
        req = request.get_json()
        brain = req.get("brain")
        execute_query(db_connect(),f'DELETE FROM brains WHERE brain={brain}')
        return f"performed DELETE on BRAIN:{brain}"

    def update(self):
        req = request.get_json()
        brain = req.get("brain")


        return f"performed DELETE on {brain}"

api.add_resource(BrainAPI, '/brains')

class BrainAPIParams(Resource):

    def delete(self, brain):
        print("DELETE REQUEST")
        connection = db_connect()
        execute_query(connection,f'DELETE FROM brains WHERE brain={brain}')
        return f"performed DELETE on {brain}"

    def put(self, sessionID):
        print("PUT/UPDATE REQUEST")
        req = request.get_json()
        time = req.get("time")
        brain = req.get("brain")
        startingFitness = req.get("startingFitness")
        endingFitness = req.get("endingFitness")
        connection = db_connect()
        execute_query(connection,f'UPDATE sessions SET brain = {brain},time = {time},startingFitness = {startingFitness},endingFitness = {endingFitness} WHERE sessionID={sessionID}')
        return f"performed Update on {sessionID}"

api.add_resource(BrainAPIParams, '/brains/<brainID>')

if __name__ == '__main__':
    app.run()
