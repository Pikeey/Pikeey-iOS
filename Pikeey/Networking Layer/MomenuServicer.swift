//
//  MomenuServicer.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

struct MomenuRestaurantRouter: Router {
    var scheme: String
    var host: String
    var path: String
    var parameters: [URLQueryItem]
    var method: String
    
    init(restaurantID id: String) {
        self.scheme = "https"
        self.host = "pikeey-backend.herokuapp.com"
        self.path = "/restaurant/restaurant/\(id)"
        self.parameters = []
        self.method = "GET"
    }
}

struct MomenuServicer: Servicer {
    static var restaurantID: String!
    let router: Router = MomenuRestaurantRouter(restaurantID: restaurantID)
}
