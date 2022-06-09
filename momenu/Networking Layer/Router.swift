//
//  Router.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

protocol Router {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
