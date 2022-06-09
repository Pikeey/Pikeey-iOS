//
//  Servicer.swift
//  Pikeey
//
//  Created by Eric Morales on 6/1/22.
//

import Foundation

protocol Servicer {
    var router: Router { get }
    func request<ResponseType: Decodable>(responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, ServicerError>) -> Void)
}

enum ServicerError: Error {
    case failToCreateURLFromComponents
    case requestFail
    case emptyResponse
    case emptyData
    case JSONDecoderFail
}

extension Servicer {
    func request<ResponseType: Decodable>(responseType: ResponseType.Type, completion: @escaping (Result<ResponseType, ServicerError>) -> Void) {
        // Components
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        // URL
        guard let url = components.url else { completion(.failure(.failToCreateURLFromComponents)); return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        // Request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // Check if an error was return
            guard error == nil else { DispatchQueue.main.async { completion(.failure(.requestFail)) }; return }
            
            // Check if a response was return
            guard response != nil else { DispatchQueue.main.async { completion(.failure(.emptyResponse)) }; return }
            
            // Check if there is any data
            guard let data = data else { DispatchQueue.main.async { completion(.failure(.emptyData)) }; return }
            
            // Decoding JSON
            do {
                let result =  try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async { completion(.success(result)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(.JSONDecoderFail)) }
            }
        }
        dataTask.resume()
    }
}
