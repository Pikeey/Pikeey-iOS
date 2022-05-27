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

enum FoodSection {
    case pasta
    case vegetarian
}

struct Foods {
    let foods: [Food]
    
    func getStartedFood() -> [Food] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == .starters { return true } else { return false }
        }
    }
    
    func getMainsFood() -> [Food] {
        return foods.filter { food in
            // If food is of category mains add it to the return array.
            if food.category == .mains { return true } else { return false }
        }
    }
    
    func getDesertsFood() -> [Food] {
        return foods.filter { food in
            // If food is of category deserts add it to the return array.
            if food.category == .deserts { return true } else { return false }
        }
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
                        description: "Secondary text",
                        price: 4.00,
                        type: .food,
                        category: .starters,
                        section: .vegetarian)
        
        return [Food](repeating: food, count: amount)
    }
    static private func getFoodMains(amount: Int) -> [Food] {
        let food = Food(name: "List item name: Mains",
                        description: "Secondary text",
                        price: 4.00,
                        type: .food,
                        category: .mains,
                        section: .pasta)
        
        return [Food](repeating: food, count: amount)
    }
    static private func getFoodDeserts(amount: Int) -> [Food] {
        let food = Food(name: "List item name: Deserts",
                        description: "Secondary text",
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
