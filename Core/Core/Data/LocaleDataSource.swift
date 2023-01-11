//
//  LocaleDataSource.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 09/01/23.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func update(entity: Response) -> AnyPublisher<Bool, Error>
    func get(id: Int) -> AnyPublisher<Bool, Error>
}
