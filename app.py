from flask import Flask

app = Flask(__name__)

@app.route('/')
def homepage():
    return "Welcome to the Flask Homepage!"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000) 

