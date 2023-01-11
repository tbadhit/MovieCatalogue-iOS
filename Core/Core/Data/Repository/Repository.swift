//
//  Repository.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 09/01/23.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
