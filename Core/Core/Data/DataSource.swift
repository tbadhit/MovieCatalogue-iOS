//
//  DataSource.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 09/01/23.
//

import Combine

public protocol DataSource {
    associatedtype Request
    associatedtype Response
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
