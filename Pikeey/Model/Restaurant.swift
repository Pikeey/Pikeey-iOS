//
//  Restaurant.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

struct Restaurant {
    let id: Int
    let name: String
    let description: String
    let logo: URL
    let image: URL
    let headChef: String
    let restaurantType: String
    var dateEstablished: Date?
    var dateCreated: Date?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss"
        
        return dateFormatter
    }()
}

extension Restaurant: Decodable {
    // Coding Keys
    enum RestaurantKeys: String, CodingKey {
        case id
        case name
        case description
        case logo
        case image
        case headChef = "head_chef"
        case restaurantType = "restaurant_type"
        case dateEstablished = "date_established"
        case dateCreated = "date_created"
    }
    
    // Decoder Initializer
    init(from decoder: Decoder) throws {
        let restaurantContainer = try decoder.container(keyedBy: RestaurantKeys.self)
        
        id = try restaurantContainer.decode(Int.self, forKey: .id)
        name = try restaurantContainer.decode(String.self, forKey: .name)
        description = try restaurantContainer.decode(String.self, forKey: .description)
        logo = try restaurantContainer.decode(URL.self, forKey: .logo)
        image = try restaurantContainer.decode(URL.self, forKey: .image)
        headChef = try restaurantContainer.decode(String.self, forKey: .headChef)
        restaurantType = try restaurantContainer.decode(String.self, forKey: .restaurantType)
        
        
        let dateEstablishedString = try restaurantContainer.decode(String.self, forKey: .dateEstablished)
        dateEstablished = getDate(from: dateEstablishedString)
        
        let dateCreatedString = try restaurantContainer.decode(String.self, forKey: .dateCreated)
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
