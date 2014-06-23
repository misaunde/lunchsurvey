#!/bin/python3



# class User:
    # def __init__(self, name, weight=1.0):
        # self.name, self.weight = name, weight

class FoodPlace:
    def __init__(self, name, menu, loc):
        self.name, self.menu, self.loc = name,menu,loc

class Database:
    def __init__(self, file):
        self.users = {}
        self.foods = []
    
    # def save(self):
        # pass
    
    # def load

db = Database('db.db')
db.users['Vitruvius'] = 1.0
db.users['80\'s Space Guy'] = 1.0
db.users['Batman'] = 1.0
db.users['Metal Beard'] = 1.0
db.users['Unikitty'] = 1.0
db.users['Wonder Woman'] = 1.0
db.users['Lord Business'] = 1.0

db.foods.append(FoodPlace('Something', 'http://www.something.com', '1416 W Something Street 12345'))
db.foods.append(FoodPlace('Something Else', 'http://www.somethingelse.com', '1417 W Something Street 12345'))