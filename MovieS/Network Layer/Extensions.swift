//
//  Extensions.swift
//  MovieS
//
//  Created by Selin Ersev on 11.04.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

extension URLComponents {
    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        var params = Parameters()
        if case let .requestParameters(parameters) = service.queryItem, service.parametersEncoding == .url {
            params = parameters
        }
        params["api_key"] = service.apikey
        queryItems = params.map{key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}

extension URLRequest {
    init(service: ServiceProtocol){
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!)
        httpMethod = service.method.rawValue
        service.headers?.forEach{key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        guard case let .requestParameters(parameters) = service.queryItem, service.parametersEncoding == .json else {return}
        httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
