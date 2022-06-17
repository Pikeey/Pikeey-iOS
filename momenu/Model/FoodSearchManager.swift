//
//  FoodSearchManager.swift
//  momenu
//
//  Created by Eric Morales on 6/10/22.
//

import Foundation

struct FoodSearchManager {
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
    
    func searchForFoodsWith(text: String) -> [Meal] {
        var results = [Meal]()
        
        let foodsWithTheTextAsName: [Meal] = getFoodsUnder(name: text)
        let foodWithTheTextAsDescription: [Meal] = getFoodsUnder(description: text)
        let foodWithTheTextAsSection: [Meal] = getFoodsUnder(section: text)
        
        let tags = text.split(separator: " ").map({ String($0) })
        let foodWithTheTextAsTags: [Meal] = getFoodsUnder(tags: tags)
        let foodWithTheTextAsChefChoice: [Meal] = getFoodUnder(chefChoice: text)
        
        results.append(contentsOf: foodsWithTheTextAsName)
        results.append(contentsOf: foodWithTheTextAsDescription)
        results.append(contentsOf: foodWithTheTextAsSection)
        results.append(contentsOf: foodWithTheTextAsTags)
        results.append(contentsOf: foodWithTheTextAsChefChoice)
        
        return results.uniqued()
    }
    
    private func getFoodsUnder(name: String) -> [Meal] {
        return foods.filter { food in
            if food.name.lowercased().contains(name.lowercased()) { return true } else { return false }
        }
    }
    
    private func getFoodsUnder(description: String) -> [Meal] {
        return foods.filter { food in
            if food.description.lowercased().contains(description.lowercased()) { return true } else { return false }
        }
    }
    
    private func getFoodsUnder(section: String) -> [Meal] {
        return foods.filter { food in
            if food.section.lowercased().contains(section.lowercased()) { return true } else { return false }
        }
    }
    
    private func getFoodsUnder(tags: [String]) -> [Meal] {
        var results = [Meal]()
        for tag in tags {
            results += foods.filter { food in food.tags.contains(tag.capitalized) }
        }
    
        return results.uniqued()
    }
    
    /// Return an array of meals that are chef choices.
    private func getFoodUnder(chefChoice: String) -> [Meal] {
        if chefChoice.lowercased() == "chef choice" {
            return foods.filter { food in
                if food.chefChoice == true { return true } else { return false }
            }
        } else {
            return []
        }
    }
    
    // With this methods you use dependency injection.
    static func getFoodUnder(type: MealType, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.type == type { return true } else { return false }
        }
    }
    
    static func getFoodUnder(category: MealCategory, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            // If food is of category starters add it to the return array.
            if food.category == category { return true } else { return false }
        }
    }
    
    static func getFoodsUnder(section: String, foods: [Meal]) -> [Meal] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
        }
    }
    
    func getSectionsFor(category: MealCategory) -> Int {
        let foodUnderDesiredCategory = self.getFoodUnder(category: category)
        
        let isThereFoodForAPastaSection: Bool = FoodSearchManager.getFoodsUnder(section: "biscuits", foods: foodUnderDesiredCategory).isEmpty
        
        var sectionsCount: Int = 0
        
        if isThereFoodForAPastaSection { sectionsCount += 1 }
        
        return sectionsCount
    }
}

// MARK: - Sequence Extension
extension Sequence where Element: Hashable {
    
    /// Return an array without its duplicates.
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

// MARK: - Meal Extension
extension Meal: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        lhs.id == rhs.id
    }
}
