import mysql.connector
from flask import Flask, jsonify, request, make_response
from flask_restful import Resource, Api, reqparse
from flask_cors import CORS
from mysql import connector

# configuration
DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)
api = Api(app)

# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})

#Connect to database
mydb = mysql.connector.connect(
    host='localhost',
    user='admin',
    password='einherjar',
    port=3306,
    database = 'gamedata'
)

mycursor = mydb.cursor()

class HelloWorld(Resource):
    def get(self):
        return {'hello': 'world'}

api.add_resource(HelloWorld, '/api')

class PingAPI(Resource):
    def get(self):
        print("Returning Ping Get")
        return "PING!"

api.add_resource(PingAPI, '/ping')

class SessionAPI(Resource):
    def get(self):
        req = request.get_json()
        key = req.get("key")
        if key == -1:
            mycursor.execute('SELECT * FROM sessions')
        else:
            mycursor.execute(f'SELECT * FROM sessions WHERE sessionID={key}')
        sessions = mycursor.fetchall()
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
        sql = 'INSERT INTO sessions (brain,time,startingFitness,endingFitness) VALUES (%s, %s, %s, %s)'
        val = (brain,time,startingFitness,endingFitness)
        mycursor.execute(sql,val)

        mydb.commit()

        return res

    def delete(self):
        sessionID = -1
        req = request.get_json()
        sessionID = req.get("sessionID")
        sql = f'DELETE FROM sessions WHERE sessionID={sessionID}'
        mycursor.execute(sql)
        mydb.commit()
        return f"performed DELETE on {sessionID}"



api.add_resource(SessionAPI, '/sessions')

class BrainAPI(Resource):
    def get(self):
        print("Returning Brain GET")
        req = request.get_json()
        key = req.get("key")
        if key == -1:
            mycursor.execute('SELECT * FROM brains')
        else:
            mycursor.execute(f'SELECT * FROM brains WHERE brain={key}')
        sessions = mycursor.fetchall()
        print("Returning Sessions GET")
        return jsonify(sessions)

    def post(self):
        req = request.get_json()
        brain = req.get("brain")
        sql = f'INSERT INTO brains (brain) VALUES ({brain})'
        mycursor.execute(sql)
        mydb.commit()
        return f"Added {brain}"

    def delete(self):
        req = request.get_json()
        brain = req.get("brain")
        sql = f'DELETE FROM brains WHERE brain={brain}'
        mycursor.execute(sql)
        mydb.commit()
        return f"performed DELETE on {brain}"

api.add_resource(BrainAPI, '/brains')




# mycursor.execute('SELECT * FROM brains')
#
# GENES = mycursor.fetchall()
#
# print(GENES)
#
# for gene in GENES:
#         print(gene)




# @app.route('/')
# def hello_world():  # put application's code here
#     return 'You shouldnt see this!!'


# # Debug route
# @app.route('/ping', methods=['GET'])
# def ping_pong():
#     return jsonify('pong from App.py!')



# @app.route('/capstone', methods=['GET',  'POST'])
# def getDegree():
#     print("getDegree called")
#     post_data = request.get_json()
#     if request.method == 'POST':
#         print(request.json)
#
#     # mydb = mysql.connector.connect(
#     #     host='localhost',
#     #     user='admin',
#     #     password='einherjar',
#     #     port=3306,
#     #     database='gamedata'
#     # )
#
#     mycursor = mydb.cursor()
#     mycursor.execute('SELECT * FROM brains')
#     return jsonify(mycursor.fetchall())

if __name__ == '__main__':
    app.run()
