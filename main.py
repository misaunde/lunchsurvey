#!/bin/python3

from bottle import route, run, view, static_file, redirect, request
import model

@route('/')
@view('base')
def hello():
    return dict(users = model.db.users, foods = model.db.foods)

@route('/static/<path:path>')
def static(path):
    return static_file(path, root='./static')

@route('/survey', method='post')
def submit():
    foods = request.forms.getall('food')
    user = request.forms.user
    print(foods, user)
    redirect('/')
run(host='localhost', port=8080, reloader=True, debug=True)