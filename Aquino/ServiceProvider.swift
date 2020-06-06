//
//  ServiceProvider.swift
//  Horoscopo
//
//  Created by Tiago Oliveira on 24/01/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

class ServiceProvider<T: ServiceProtocol> {
    var urlSession = URLSession.shared
    var task: URLSessionDataTask?
    
    init() { }
    
    func execute(service: T, completion: @escaping (Result<Data>) -> Void) throws {
        do {
            let request = try service.urlRequest()
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
    
    func stopRequestOnGoing() {
        if let task = task {
            task.cancel()
        }
    }
}
