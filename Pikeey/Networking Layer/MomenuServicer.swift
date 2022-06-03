//
//  MomenuServicer.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

struct MomenuRouter: Router {
    var scheme: String = "https"
    var host: String = "pikeey-backend.herokuapp.com"
    var path: String = "/restaurant/restaurant/1"
    var parameters: [URLQueryItem] = []
    var method: String = "GET"
}

struct MomenuServicer: Servicer {
    let router: Router = MomenuRouter()
}
