//
//  Mapper.swift
//  Core
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation

public protocol Mapper {
    associatedtype Request
    associatedtype Responses
    associatedtype Entities
    associatedtype Domains
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Responses) -> Entities
    func transformEntityToDomain(entity: Entities) -> Domains
    func transformResponseToDomain(response: Responses) -> Domains
    func transformDomainToEntity(model: Domain) -> Entity
}
