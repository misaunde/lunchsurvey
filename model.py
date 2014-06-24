#!/usr/bin/python3


max_votes = 5


class FoodPlace:
    def __init__(self, name, menu, loc):
        self.name, self.menu, self.loc = name, menu, loc


class Database:
    def __init__(self, file):
        self.users = {}
        self.foods = []
        self.votes = {}
        self.results = None

    def calc_results(self):
        voters, weights = {food.name: [] for food in self.foods}, {food.name: 0. for food in self.foods}
        #calc weights for foods
        for user, user_foods in self.votes.items():
            user_weight = self.users[user]
            for rank, user_food in enumerate(user_foods):
                user_food_weight = user_weight * (max_votes - rank)
                weights[user_food] += user_food_weight
                voters[user_food].append((user, rank))
        weights = [(food, weight) for (food, weight) in weights.items() if weight > 0.]
        weights.sort(key=lambda x: (x[1], x[0]), reverse=True)

        #adjust weights
        weight_factors = {user: 1.0 for user in self.users}
        if weights:
            winners = voters[weights[0][0]]
            for winner, rank in winners:
                weight_factors[winner] = 1.0 - (max_votes - rank) / max_votes
        for user, weight_factor in weight_factors.items():
            db.users[user] = (db.users[user] + weight_factor) / 2

        #save results
        self.results = (weights, voters)


db = Database('db.db')
db.users['Vitruvius'] = 1.0
db.users['80\'s Space Guy'] = 1.0
#db.users['Batman'] = 1.0
#db.users['Metal Beard'] = 1.0
#db.users['Unikitty'] = 1.0
#db.users['Wonder Woman'] = 1.0
#db.users['Lord Business'] = 1.0

db.foods.append(FoodPlace('Something', 'http://www.something.com', '1416 W Something Street 12345'))
db.foods.append(FoodPlace('Something Else', 'http://www.somethingelse.com', '1417 W Something Street 12345'))
db.foods.append(FoodPlace('Even Something Else', 'http://www.somethingelse.com', '1417 W Something Street 12345'))