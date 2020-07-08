from flask import Flask, render_template, request

app = Flask(__name__)


@app.route('/')
def hello():
    return render_template('first.html',
                           title='Home',
                           xff=request.headers.get('X-Forwarded-For')
                           or 'unkown',
                           host=request.headers.get('Host') or 'unkown')


if __name__ == '__main__':
    app.run()
