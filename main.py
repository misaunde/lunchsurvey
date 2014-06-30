#!/usr/bin/python3

import itertools
from bottle import route, run, view, static_file, redirect, request, response
import model
import datetime
import sys

max_votes = model.max_votes
db = model.Database(sys.argv[1] if len(sys.argv) > 1 else 'db.db')
started = False


def auth(method):
    def wrapper(*args, **kwargs):
        user = request.get_cookie("user")
        if user:
            kwargs['user'] = user
            return method(*args, **kwargs)
        else:
            redirect('/who')

    return wrapper

@route('/admin')
@view('admin')
def admin():
    return dict(started=started)

@route('/user', method='post')
def user_post():
    db.add_user(request.forms.name, float(request.forms.weight))
    redirect('/admin')

@route('/reset', method='post')
def reset():
    db.reset()
    redirect('/admin')

@route('/results', method='post')
def results():
    db.calc_results()
    redirect('/admin')
    
@route('/start', method='post')
def start():
    global started
    started = True
    redirect('/admin')
    
@route('/stop', method='post')
def stop():
    global started
    started = False
    redirect('/admin')

@route('/')
@view('index')
@auth
def index(user):
    dates = db.get_dates()
    return dict(has_voted=user in db.votes, users=db.get_users(), foods=db.get_foodplaces(), max_votes=max_votes, results=db.results, started=started, dates=dates)

@route('/history')
@view('history')
def history():
    date = datetime.datetime.strptime(request.query['date'], '%Y-%m-%d').date()
    return dict(sel_date=date, dates=db.get_dates(), results=db.get_results(date))

@route('/who', method='get')
@view('who')
def who_get():
    return dict(users=db.get_users())


@route('/who', method='post')
def who_post():
    response.set_cookie('user', request.forms.user)
    redirect('/')


@route('/food', method='post')
def food():
    db.add_foodplace(request.forms.name, request.forms.menu, request.forms.loc)
    redirect('/')


@route('/static/<path:path>')
def static(path):
    return static_file(path, root='./static')


@route('/survey', method='post')
@auth
def submit(user):
    foods = list(itertools.takewhile(lambda x: x != '__sentinel__', request.forms.getall('food')))[:max_votes]
    print(foods, user)
    db.votes[user] = foods
    redirect('/')


run(host='0.0.0.0', port=8080)
# run(host='localhost', port=8080, reloader=True, debug=True)
