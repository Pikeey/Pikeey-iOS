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
    case none
    
    init(string: String) {
        switch string {
        case "food":
            self = .food
        case "drink":
            self = .drink
        default:
            self = .none
        }
    }
}

enum MealCategory {
    case starters
    case mains
    case desserts
    case cold
    case hot
    case none
    
    init(string: String) {
        switch string {
        case "starter":
            self = .starters
        case "main":
            self = .mains
        case "dessert":
            self = .desserts
        case "cold":
            self = .cold
        case "hot":
            self = .hot
        default:
            self = .none
        }
    }
}

enum FoodSection: String {
    case pasta = "Pasta"
    case vegetarian = "Vegetarian"
}

struct Foods {
    var foods: [Meal]
    
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
    
    func getFoodsUnder(section: String) -> [Meal] {
        return foods.filter { food in
            if food.section == section { return true } else { return false }
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
        
        let isThereFoodForAPastaSection: Bool = Foods.getFoodsUnder(section: "biscuits", foods: foodUnderDesiredCategory).isEmpty
        
        var sectionsCount: Int = 0
        
        if isThereFoodForAPastaSection { sectionsCount += 1 }
        
        return sectionsCount
    }
}

struct Meal {
    let id: Int
    let name: String
    let description: String
    let section: String
    let type: MealType
    let category: MealCategory
    let ingredients: [String]
    let tags: [String]
    let price: Double
    var chefChoice: Bool?
    var dateCreated: Date?
    let restaurantID: Int
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        
        return dateFormatter
    }()
}

extension Meal: Decodable {
    // Coding Keys
    enum MealKeys: String, CodingKey {
        case id
        case name
        case description
        case section
        case type = "dish_type"
        case category
        case ingredients
        case tags
        case price
        case chefChoice = "chef_choice"
        case dateCreated = "date_created"
        case restaurantID = "restaurant"
    }
    
    // Decoder Initializer
    init(from decoder: Decoder) throws {
        let mealContainer = try decoder.container(keyedBy: MealKeys.self)
        
        id = try mealContainer.decode(Int.self, forKey: .id)
        name = try mealContainer.decode(String.self, forKey: .name).capitalized
        var descriptionAsSentence = try mealContainer.decode(String.self, forKey: .description)
        description = descriptionAsSentence.makeSentence()
        section = try mealContainer.decode(String.self, forKey: .section)
        
        let typeString = try mealContainer.decode(String.self, forKey: .type)
        type = MealType(string: typeString)
        let categoryString = try mealContainer.decode(String.self, forKey: .category)
        category = MealCategory(string: categoryString)
        
        ingredients = try mealContainer.decode([String].self, forKey: .ingredients).map({ $0.capitalized })
        tags = try mealContainer.decode([String].self, forKey: .tags).map({ $0.capitalized })
        let priceString = try mealContainer.decode(String.self, forKey: .price)
        price = Double(priceString) ?? 0
        
        chefChoice = try mealContainer.decode(Bool.self, forKey: .chefChoice)
        restaurantID = try mealContainer.decode(Int.self, forKey: .restaurantID)
        
        let dateCreatedString = try mealContainer.decode(String.self, forKey: .dateCreated)
        dateCreated = getDate(from: dateCreatedString)
    }
    
    private func getDate(from dateString: String) -> Date? {
        let start = dateString.startIndex
        let end = dateString.index(start, offsetBy: 19)
        let dateRange = start..<end
        
        let parseDate = String(dateString[dateRange])
        
        return dateFormatter.date(from: parseDate)
    }
}

extension String {
    private func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    /// This method capitalize the first letter and add a period at the end.
    mutating func makeSentence() -> String{
        var result = self.capitalizingFirstLetter()
        result += "."
        return result
    }
}
