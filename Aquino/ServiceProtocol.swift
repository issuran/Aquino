//
//  ServiceProtocol.swift
//  Horoscopo
//
//  Created by Tiago Oliveira on 24/01/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum HttpTask {
    case request
    case requestUrlParameters(urlParameters: Parameters)
    case requestBodyParameters(bodyParameters: Parameters)
    case requestParameters(bodyParameters: Parameters,
                           urlParameters: Parameters)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionalHeaders: HTTPHeaders)
}

public enum Result<T> {
    case success(T, URLResponse?)
    case failure(Error)
    case empty
}

public protocol ServiceProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var task: HttpTask { get }
}

extension ServiceProtocol {
    public func urlRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        guard let url = components.url else { fatalError("Could not create URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        do {
            switch task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestUrlParameters(let urlParameters):
                try self.configureParameters(bodyParameters: nil,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestBodyParameters(let bodyParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: nil,
                                             request: &request)
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
        } catch {
            throw error
        }
        return request
    }
    
    private func configureParameters(bodyParameters: Parameters?,
                                       urlParameters: Parameters?,
                                       request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
