//
//  Food.swift
//  Pikeey
//
//  Created by Eric Morales on 5/26/22.
//

import Foundation

enum MealType {
    case food
    case drink
}

enum MealCategory {
    case startersFood
    case mainsFood
    case desertsFood
    case coldDrink
    case hotDrink
}

enum FoodSection: String {
    case pasta = "Pasta"
    case vegetarian = "Vegetarian"
}

struct Foods {
    let foods: [Meal]
    
    // This methods perform the work on self.
    func getFoodUnder(type: MealType) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.type == type { return true } else { return false }
        }
    }
    
    func getFoodUnder(category: MealCategory) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == category { return true } else { return false }
        }
    }
    
    func getFoodsUnder(section: FoodSection) -> [Meal] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
        }
    }
    
    // With this methods you use dependency injection.
    func getFoodUnder(type: MealType, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.type == type { return true } else { return false }
        }
    }
    
    func getFoodUnder(category: MealCategory, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == category { return true } else { return false }
        }
    }
    
    func getFoodsUnder(section: FoodSection, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
        }
    }
    
    func getSectionsFor(category: MealCategory) -> Int {
        let foodUnderDesiredCategory = self.getFoodUnder(category: category)
        
        let isThereFoodForAPastaSection: Bool = self.getFoodsUnder(section: .pasta, foods: foodUnderDesiredCategory).isEmpty
        let isThereFoodForAVegetarianSection: Bool = self.getFoodsUnder(section: .vegetarian, foods: foodUnderDesiredCategory).isEmpty
        
        var sectionsCount: Int = 0
        
        if isThereFoodForAPastaSection { sectionsCount += 1 }
        if isThereFoodForAVegetarianSection { sectionsCount += 1 }
        
        return sectionsCount
    }
    
    // HARDCODED DATA TO TEST
    static func getFood() -> [Meal] {
        return [
            Meal(name: "Chips", description: "Cheesy chips.", price: 2, type: .food, category: .startersFood, section: .vegetarian),
            Meal(name: "Caponata Alla Siciliana", description: "A sensational Sicilian vegan recipe.", price: 3, type: .food, category: .startersFood, section: .vegetarian),
            Meal(name: "Manicotti", description: "Delicious! Serve with a crispy salad and garlic bread.", price: 10, type: .food, category: .mainsFood, section: .pasta),
            Meal(name: "Sugar Cookies", description: "Butter and eggs? Who needs 'em?!", price: 6, type: .food, category: .desertsFood, section: .vegetarian),
            Meal(name: "Carrot Cake", description: "This is a luscious carrot cake, free of any animal products!", price: 8, type: .food, category: .desertsFood, section: .vegetarian)
        ]
    }
    static func getDrinks() -> [Meal] {
        return [
            Meal(name: "Piña Colada", description: "Get a taste for the tropics.", price: 6, type: .food, category: .coldDrink , section: nil),
            Meal(name: "Lemonade", description: "Our refreshing lemonade recipe makes the best-tasting glass ever!", price: 6, type: .drink, category: .coldDrink, section: nil),
            Meal(name: "Latte", description: "Best coffee you will ever get.", price: 4, type: .drink, category: .hotDrink, section: nil)
        ]
    }
}

struct Meal {
    let name: String
    let description: String
    let price: Double
    let type: MealType
    let category: MealCategory
    let section: FoodSection?
}
