import mysql.connector
from flask import Flask, jsonify, request
from flask_cors import CORS
from mysql import connector

# configuration
DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)


# enable CORS
CORS(app, resources={r'/*': {'origins': '*'}})

mydb = mysql.connector.connect(
    host='localhost',
    user='admin',
    password='einherjar',
    port=3306,
    database = 'gamedata'
)


mycursor = mydb.cursor()

mycursor.execute('SELECT * FROM brains')

GENES = mycursor.fetchall()

print(GENES)

for gene in GENES:
        print(gene)

BOOKS = [
    {
        'title': 'On the Road',
        'author': 'Jack Kerouac',
        'read': True
    },
    {
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J. K. Rowling',
        'read': False
    },
    {
        'title': 'Green Eggs and Ham',
        'author': 'Dr. Seuss',
        'read': True
    }
]

print(BOOKS)


@app.route('/books', methods=['GET', 'POST'])
def all_books():
    response_object = {'status': 'success'}

    if request.method == 'POST':
        post_data = request.get_json()
        print(request)
        print("Received:")
        print("POST_DATA:"+post_data)
        BOOKS.append({
            #'title': post_data.get('title'),
            #'author': post_data.get('author'),
            #'read': post_data.get('read')
            # 'title': 'foo',
            # 'author': 'bar',
            # 'read': 'bar'
        })
        response_object['message'] = 'Book added!'
    else:
        response_object['books'] = BOOKS
    return jsonify(response_object)


@app.route('/')
def hello_world():  # put application's code here
    return 'You shouldnt see this!!'


# Debug route
@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong from App.py!')

@app.route('/capstone', methods=['GET',  'POST'])
def getDegree():
    post_data = request.get_json()
    #print(request)
    #print(post_data)
    if request.method == 'POST':

        print(request.data)
        print(request.form)
        print(request.values)
        print(request.form.to_dict().keys())
        print(request.content_type)
        #print(request.get_json(force=True))

        print(request.json)
        #print(request.form.getList("Potato"))
        #print(request.args)

    mydb = mysql.connector.connect(
        host='localhost',
        user='admin',
        password='einherjar',
        port=3306,
        database='gamedata'
    )

    mycursor = mydb.cursor()

    mycursor.execute('SELECT * FROM sessions')

    return jsonify(mycursor.fetchall())

if __name__ == '__main__':
    app.run()
