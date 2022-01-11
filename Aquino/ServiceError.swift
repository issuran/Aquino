//
//  ServiceError.swift
//  Aquino
//
//  Created by Tiago Oliveira on 24/01/20.
//  Copyright © 2020 Tiago Oliveira. All rights reserved.
//

import Foundation

public enum ServiceError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters encoding failed."
    case missingURL = "URL is nil."
    case notPossibleRetrieve = "Could not retrieve data."
    case parseError = "Parse error."
}
