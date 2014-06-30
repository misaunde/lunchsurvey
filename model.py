#!/usr/bin/python3
import json
import sqlite3
import datetime
max_votes = 5


class FoodPlace:
    def __init__(self, name, menu, loc):
        self.name, self.menu, self.loc = name, menu, loc


class Database:
    def __init__(self, file):
        self._conn = sqlite3.connect(file, detect_types=sqlite3.PARSE_DECLTYPES, isolation_level = None)
        c = self._conn.cursor()
        c.execute('CREATE TABLE IF NOT EXISTS user (name text, weight real)')
        c.execute('CREATE TABLE IF NOT EXISTS foodplace (name text, menu text, loc text)')
        c.execute('CREATE TABLE IF NOT EXISTS result (weights text, voters text, users text, dt date)')
        self.votes = {}
        self.results = None

    def reset(self):
        self.votes = {}
        self.results = None

    def add_user(self, user, weight=1.0):
        c = self._conn.cursor()
        c.execute('INSERT INTO user(name, weight) values (?,?)', (user, weight))
    
    def add_foodplace(self, name, menu, loc):
        c = self._conn.cursor()
        c.execute('INSERT INTO foodplace(name, menu, loc) values (?,?,?)', (name, menu, loc))
        
    def get_users(self):
        c = self._conn.cursor()
        return [(name, weight) for name, weight in c.execute('SELECT * FROM user ORDER BY weight DESC')]
    
    def update_users(self, weights):
        c = self._conn.cursor()
        c.executemany('UPDATE user SET weight = ? WHERE name = ?', [(weight, name) for (name, weight) in weights.items()])
        
    def get_foodplaces(self):
        c = self._conn.cursor()
        return [row for row in c.execute('SELECT * FROM foodplace ORDER BY name')]
        
    def get_results(self, date):
        c = self._conn.cursor()
        w,v,u,dt = c.execute('SELECT * FROM result WHERE dt = ?', (date,)).fetchone()
        return json.loads(w), json.loads(v), json.loads(u)
    
    def get_dates(self):
        c = self._conn.cursor()
        return [d for (d,) in c.execute('SELECT dt FROM result')]
    
    def _save_results(self, weights, voters, users, date=datetime.date.today()):
        c = self._conn.cursor()
        c.execute('INSERT INTO result(dt, weights, voters, users) values(?,?,?,?)', (date, json.dumps(weights),json.dumps(voters),json.dumps(users)))
        
    def calc_results(self):
        foods = self.get_foodplaces()
        users = {name:weight for name, weight in self.get_users()}
        voters, weights = {food[0]: [] for food in foods}, {food[0]: 0. for food in foods}
        #calc weights for foods
        for user, user_foods in self.votes.items():
            user_weight = users[user]
            for rank, user_food in enumerate(user_foods):
                user_food_weight = user_weight * (max_votes - rank)
                weights[user_food] += user_food_weight
                voters[user_food].append((user, rank))
        weights = [(food, weight) for (food, weight) in weights.items() if weight > 0.]
        weights.sort(key=lambda x: (x[1], x[0]), reverse=True)

        #adjust weights
        weight_factors = {user: 1.0 for user in users}
        if weights:
            winners = voters[weights[0][0]]
            for winner, rank in winners:
                weight_factors[winner] = 1.0 - (max_votes - rank) / max_votes
        self.update_users({user: (users[user] + weight_factor) / 2 for user, weight_factor in weight_factors.items()})

        #save results
        self.results = (weights, voters, users)
        self._save_results(*self.results)
