//
//  GetPopularMoviesLocaleDataSource.swift
//  Movie
//
//  Created by Tubagus Adhitya Permana on 10/01/23.
//

import Foundation
import Combine
import Core
import RealmSwift

public struct GetPopularMoviesLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = MovieEntity
    private let _realm: Realm
    public init(realm: Realm) {
        _realm = realm
    }
    public func list(request: Any?) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> {completion in
            let popularMovies: Results<MovieEntity> = {
                _realm.objects(MovieEntity.self)
                    .sorted(byKeyPath: "title", ascending: true)
            }()
            completion(.success(popularMovies.toArray(ofType: MovieEntity.self)))
        }
        .eraseToAnyPublisher()
    }
    public func add(entities: [MovieEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for movie in entities {
                        _realm.add(movie, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    public func update(entity: MovieEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
