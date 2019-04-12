//
//  Protocols.swift
//  MovieS
//
//  Created by Selin Ersev on 11.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol ServiceProtocol {
    var baseURL: URL {get}
    var path: String {get}
    var apikey: String {get}
    var method: HTTPMethod {get}
    var queryItem: QueryItem {get}
    var headers: Headers? {get}
    var parametersEncoding: ParametersEncoding {get}
}

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}
