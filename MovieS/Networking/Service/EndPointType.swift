
//
//  EndPointType.swift
//  MovieS
//
//  Created by Selin Ersev on 25.02.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
