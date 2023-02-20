//
//  URLSessionProtocol.swift
//  Aquino
//
//  Created by Tiago Oliveira on 20/02/23.
//  Copyright © 2023 Tiago Oliveira. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
