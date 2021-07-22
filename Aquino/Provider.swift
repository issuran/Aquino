//
//  Provider.swift
//  Horoscopo
//
//  Created by Tiago Oliveira on 07/06/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

open class Provider {
    var urlSession = URLSession.shared
    var task: URLSessionDataTask?
    
    public init() { }
    
    public func execute<T: Decodable>(endpoint: ServiceProtocol, completion: @escaping (Result<T, Error>) -> Void) throws {
        do {
            let request = try endpoint.urlRequest()
            task = urlSession.dataTask(with: request) { (data, response, error) in
                Decoder.decode(model: T.self, data: data, response: response, error: error) { (result) in
                    switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            task?.resume()
        } catch {
            throw error
        }
    }
    
    public func stopRequestOnGoing() {
        if let task = task {
            task.cancel()
        }
    }
}
