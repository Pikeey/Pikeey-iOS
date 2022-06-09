//
//  MomenuRouterBuilder.swift
//  Pikeey
//
//  Created by Eric Morales on 6/3/22.
//

import UIKit

protocol RouterBuilder: Router {
   func construct() -> Router
}

struct MomenuRouteBuilder: RouterBuilder {
    var scheme: String = "https"
    var host: String = "pikeey-backend.herokuapp.com"
    var path: String = "/restaurant"
    var parameters: [URLQueryItem] = []
    var method: String = "GET"
    
    func construct() -> Router {
        return MomenuRoute(scheme: scheme, host: host, path: path, parameters: parameters, method: method)
    }
}

struct MomenuRouterDirector {
    let restaurantID: String
    
    func createRouteForRestaurantInfo() -> Router {
        var builder = MomenuRouteBuilder()
        builder.path += "/\(restaurantID)"
        
        return builder.construct()
    }
    
    func createRouteForResturantMenu() -> Router {
        var builder = MomenuRouteBuilder()
        builder.path += "/menu"
        builder.parameters = [
            URLQueryItem(name: "restaurant_id", value: restaurantID)
        ]
        
        return builder.construct()
    }
}
