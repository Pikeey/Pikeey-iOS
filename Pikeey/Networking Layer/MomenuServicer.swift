//
//  MomenuServicer.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

enum requestType {
    case restaurantInfo
    case restaurantMenu
}

struct MomenuRoute: Router {
    var scheme: String
    var host: String
    var path: String
    var parameters: [URLQueryItem]
    var method: String
}

struct MomenuServicer: Servicer {
    static var restaurantID: String! // After scanning this property is populated
    var requestType: requestType
    
    // Computes the correct router to be used by the request method depending on the requestType.
    var router: Router {
        switch requestType {
        case .restaurantInfo:
            return MomenuRouterDirector(restaurantID: MomenuServicer.restaurantID).createRouteForRestaurantInfo()
            
        case .restaurantMenu:
            return MomenuRouterDirector(restaurantID: MomenuServicer.restaurantID).createRouteForResturantMenu()
            
        }
    }
}
