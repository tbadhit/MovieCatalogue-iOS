//
//  UseCase.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
