#!/usr/bin/python3

import itertools

from bottle import route, run, view, static_file, redirect, request, response
import model


max_votes = model.max_votes
db = model.db


def auth(method):
    def wrapper(*args, **kwargs):
        user = request.get_cookie("user")
        if user:
            kwargs['user'] = user
            return method(*args, **kwargs)
        else:
            redirect('/who')

    return wrapper


@route('/')
@view('base')
@auth
def index(user):
    return dict(has_voted=user in db.votes, users=db.users, foods=db.foods, max_votes=max_votes, results=db.results)


@route('/who', method='get')
@view('who')
def who_get():
    return dict(users=db.users)


@route('/who', method='post')
@view('who')
def who_post():
    response.set_cookie('user', request.forms.user)
    redirect('/')


@route('/food', method='post')
@view('who')
def food():
    db.foods.append(db.FoodPlace(request.forms.name, request.forms.menu, request.forms.loc))
    redirect('/')


@route('/static/<path:path>')
def static(path):
    return static_file(path, root='./static')


@route('/survey', method='post')
@auth
def submit(user):
    foods = set(list(itertools.takewhile(lambda x: x != '__sentinel__', request.forms.getall('food')))[:max_votes])
    print(foods, user)
    db.votes[user] = foods
    if len(db.votes) == len(db.users):
        db.calc_results()
    redirect('/')


run(host='localhost', port=8080, reloader=True, debug=True)