//
//  Enums.swift
//  MovieS
//
//  Created by Selin Ersev on 11.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

typealias Parameters = [String:Any]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum QueryItem {
    case requestPlain
    case requestParameters(Parameters)
}

enum ParametersEncoding {
    case url
    case json
}

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case unknown
    case noJSONData
}
