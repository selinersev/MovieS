//
//  NetworkRouter.swift
//  MovieS
//
//  Created by Selin Ersev on 25.02.2019.
//  Copyright © 2019 Selin Ersev. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
