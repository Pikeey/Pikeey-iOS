//
//  Food.swift
//  Pikeey
//
//  Created by Eric Morales on 5/26/22.
//

import Foundation

enum FoodType {
    case food
    case drink
}

enum FoodCategory {
    case starters
    case mains
    case deserts
}

enum FoodSection: String {
    case pasta = "Pasta"
    case vegetarian = "Vegetarian"
}

struct Foods {
    let foods: [Food]
    
    // This methods perform the work on self.
    func getFoodUnder(type: FoodType) -> [Food] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.type == type { return true } else { return false }
        }
    }
    
    func getFoodUnder(category: FoodCategory) -> [Food] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == category { return true } else { return false }
        }
    }
    
    func getFoodsUnder(section: FoodSection) -> [Food] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
        }
    }
    
    // With this methods you use dependency injection.
    func getFoodUnder(type: FoodType, foods: [Food]) -> [Food] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.type == type { return true } else { return false }
        }
    }
    
    func getFoodUnder(category: FoodCategory, foods: [Food]) -> [Food] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == category { return true } else { return false }
        }
    }
    
    func getFoodsUnder(section: FoodSection, foods: [Food]) -> [Food] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
        }
    }
    
    func getSectionsFor(category: FoodCategory) -> Int {
        let foodUnderDesiredCategory = self.getFoodUnder(category: category)
        
        let isThereFoodForAPastaSection: Bool = self.getFoodsUnder(section: .pasta, foods: foodUnderDesiredCategory).isEmpty
        let isThereFoodForAVegetarianSection: Bool = self.getFoodsUnder(section: .vegetarian, foods: foodUnderDesiredCategory).isEmpty
        
        var sectionsCount: Int = 0
        
        if isThereFoodForAPastaSection { sectionsCount += 1 }
        if isThereFoodForAVegetarianSection { sectionsCount += 1 }
        
        return sectionsCount
    }
    
    // HARDCODED DATA TO TEST
    static func getFood() -> [Food] {
        var food = [Food]()
        
        let starters = getFoodStarters(amount: 3)
        let mains = getFoodMains(amount: 2)
        let deserts = getFoodDeserts(amount: 3)
        
        food.append(contentsOf: starters)
        food.append(contentsOf: mains)
        food.append(contentsOf: deserts)
        
        return food
    }
    static private func getFoodStarters(amount: Int) -> [Food] {
        let food = Food(name: "List item name: Starters",
                        description: "Secondary text: Vegetarian",
                        price: 4.00,
                        type: .food,
                        category: .starters,
                        section: .vegetarian)
        
        return [Food](repeating: food, count: amount)
    }
    static private func getFoodMains(amount: Int) -> [Food] {
        let food = Food(name: "List item name: Mains",
                        description: "Secondary text: Pasta",
                        price: 4.00,
                        type: .food,
                        category: .mains,
                        section: .pasta)
        
        return [Food](repeating: food, count: amount)
    }
    static private func getFoodDeserts(amount: Int) -> [Food] {
        let food = Food(name: "List item name: Deserts",
                        description: "Secondary text: Vegetarian",
                        price: 4.00,
                        type: .food,
                        category: .deserts,
                        section: .vegetarian)
        
        return [Food](repeating: food, count: amount)
    }
}

struct Food {
    let name: String
    let description: String
    let price: Double
    let type: FoodType
    let category: FoodCategory
    let section: FoodSection
}
