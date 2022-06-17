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
    case alcoholic
    case nonAlcoholic
    case none
    
    init(string: String) {
        switch string {
        case "starter":
            self = .starters
        case "main":
            self = .mains
        case "dessert":
            self = .desserts
        case "alcoholic":
            self = .alcoholic
        case "non-alcoholic":
            self = .nonAlcoholic
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
    var searchManager: FoodSearchManager
    
    init(foods: [Meal]) {
        self.foods = foods
        self.searchManager = FoodSearchManager(foods: foods)
    }
}

struct Meal {
    let id: Int
    let name: String
    let description: String
    let image: URL
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
        case image
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
        image = try mealContainer.decode(URL.self, forKey: .image)
        section = try mealContainer.decode(String.self, forKey: .section).capitalized
        
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
