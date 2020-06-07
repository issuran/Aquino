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
    
    public func execute(endpoint: ServiceProtocol, completion: @escaping (Result<Data>) -> Void) throws {
        do {
            let request = try endpoint.urlRequest()
            task = urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data, response))
                } else {
                    completion(.empty)
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
