
//
//  HTTPTask.swift
//  MovieS
//
//  Created by Selin Ersev on 25.02.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]


public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}


